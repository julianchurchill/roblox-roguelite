local module = {}

local addCoinsRemoteFn = game.ReplicatedStorage.Shared:WaitForChild("AddCoinsRemoteFn")
local DataStoreService = require(script.Parent.Parent.DataStoreServiceWrapper)
local DataStoreUtils = require(script.Parent.Parent.Modules.DataStoreUtils)
local PlayerInventory = DataStoreService:GetDataStore("PlayerInventory")
local CoinsChangedEvent = game.ReplicatedStorage.Shared:WaitForChild("CoinsChangedEvent")
local Range = require(script.Parent.Parent.Modules.Range)

local coinsDataStoreKey = "Coins"
local defaultCoins = 0

function module.GetCurrentCoins(Player)
    local success, result = pcall(function()
        return PlayerInventory:GetAsync(DataStoreUtils.MakeDataStoreKeyForPlayer(Player, coinsDataStoreKey))
    end)
    if success then
        return result
    else
        print("Error getting coins: " .. result)
        return defaultCoins
    end
end

local function UpdateCoins(Player, UpdateFunc)
    local success, result = pcall(function()
        return PlayerInventory:UpdateAsync(DataStoreUtils.MakeDataStoreKeyForPlayer(Player, coinsDataStoreKey), UpdateFunc)
    end)
    if success then
        CoinsChangedEvent:Fire(result)
        print("Coins updated to: " .. result)
        return result
    else
        print("Error updating coins: " .. result)
        return module.GetCurrentCoins(Player)
    end
end

local maxDistanceToCoins = 5

function AddCoinsServerInvoke()
    addCoinsRemoteFn.OnServerInvoke = function(player, numberOfCoinsToAdd, coin)
        if Range.InRange(coin, player.Character:FindFirstChild("HumanoidRootPart"), maxDistanceToCoins) then
            UpdateCoins(player, function(currentCoins)
                return currentCoins + numberOfCoinsToAdd
            end)
            return "SUCCESS"
        end
        return "FAILURE"
    end
end

function SetCurrentCoins(Player, coins)
    local success, result = pcall(function()
        return PlayerInventory:SetAsync(DataStoreUtils.MakeDataStoreKeyForPlayer(Player, coinsDataStoreKey), coins)
    end)
    if success then
        CoinsChangedEvent:Fire(coins)
        print("Coins set to: " .. coins)
    else
        print("Error setting coins: " .. result)
    end
end

function module.CoinsChangedEventConnect(func)
    CoinsChangedEvent.Event:Connect(func)
end

function module.Initialize(Player)
    if module.GetCurrentCoins(Player) == nil then
        SetCurrentCoins(Player, defaultCoins)
    end
    AddCoinsServerInvoke()
end

return module