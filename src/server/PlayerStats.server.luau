local Coins = require(script.Parent.PlayerInventory.Coins)
local Experience = require(script.Parent.Stats.Experience)

local function AddPlayerStat(playerStats, defaultValue, name, connectProvider, player)
    local thing = Instance.new("NumberValue")
    thing.Parent = playerStats;
    thing.Name = name
    local currentValue = connectProvider.GetCurrentValue(player)
    if currentValue == nil then
        thing.Value = defaultValue
    else
        thing.Value = currentValue
    end

    connectProvider.ChangedEventConnect(function(newValue)
        thing.Value = newValue
    end)
end

game.Players.PlayerAdded:Connect(function(player)
    local playerStats = Instance.new("Folder")
    playerStats.Parent = player;
    playerStats.Name = "PlayerStats"

    AddPlayerStat(playerStats, 0, "Coins", Coins, player)
    AddPlayerStat(playerStats, 0, "Experience", Experience, player)
end)
