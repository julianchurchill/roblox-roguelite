local module = {}

local addCoinsFn = game.ReplicatedStorage.Shared.AddCoinsFn
local DataStoreService = game:GetService("DataStoreService")
local PlayerInventory = DataStoreService:GetDataStore("PlayerInventory")

local function MakeDataStoreKeyForPlayer(player, identifier)
    return identifier .. "/" .. player.UserId
end

local coinsDataStoreKey = "Coins"
local defaultCoins = 0

function module.GetCurrentCoins(Player)
    local success, result = pcall(function()
        return PlayerInventory:GetAsync(MakeDataStoreKeyForPlayer(Player, coinsDataStoreKey))
    end)
    if success then
        return result
    else
        print("Error getting coins: " .. result)
        return defaultCoins
    end
end

local function InRange(part1, part2, maxDistance)
    local distance = (part1.Position - part2.Position).Magnitude
    return distance <= maxDistance
end

local function UpdateCoins(Player, UpdateFunc)
    local success, result = pcall(function()
        return PlayerInventory:UpdateAsync(MakeDataStoreKeyForPlayer(Player, coinsDataStoreKey), UpdateFunc)
    end)
    if success then
        -- TODO: make success call a bindable event, get PlayerStats script to bind to it for updates
        return result
    else
        print("Error updating coins: " .. result)
        return module.GetCurrentCoins(Player)
    end
end

local maxDistanceToCoins = 5

function AddCoinsServerInvoke()
    addCoinsFn.OnServerInvoke = function(player, numberOfCoinsToAdd, coin)
        if InRange(coin, player.Character:FindFirstChild("HumanoidRootPart"), maxDistanceToCoins) then
            -- TODO: use a bindable event from SetCurrentCoins and UpdateCoins instead of setting PlayerStats directly
            local playerStats = player:FindFirstChild("PlayerStats")
            local coins = playerStats:FindFirstChild("Coins")
            coins.Value = UpdateCoins(player, function(currentCoins)
                return currentCoins + numberOfCoinsToAdd
            end)
            return "SUCCESS"
        end
        return "FAILURE"
    end
end

function SetCurrentCoins(Player, coins)
    local success, result = pcall(function()
        return PlayerInventory:SetAsync(MakeDataStoreKeyForPlayer(Player, coinsDataStoreKey), coins)
    end)
    -- TODO: make success call a bindable event, get PlayerStats script to bind to it for updates
    if not success then
        print("Error setting coins: " .. result)
    end
end

function module.Initialize(Player)
    if module.GetCurrentCoins(Player) == nil then
        SetCurrentCoins(Player, defaultCoins)
    end
    AddCoinsServerInvoke()
end

return module