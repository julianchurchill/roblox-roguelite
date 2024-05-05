local Coins = require(script.Parent.PlayerInventory.Coins)
local Experience = require(script.Parent.Stats.Experience)

local function AddStat(playerStats, defaultValue, name, connectProvider, player)
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

local function AddPlayerStats(player)
    local playerStats = Instance.new("Folder")
    playerStats.Parent = player;
    playerStats.Name = "PlayerStats"

    AddStat(playerStats, 0, "Coins", Coins, player)
    AddStat(playerStats, 0, "Experience", Experience, player)
end

local function AddLeaderStats(player)
    local leaderStats = Instance.new("Folder")
    leaderStats.Parent = player;
    leaderStats.Name = "leaderstats"

    AddStat(leaderStats, 0, "Coins", Coins, player)
    AddStat(leaderStats, 0, "Experience", Experience, player)
end

game.Players.PlayerAdded:Connect(function(player)
    AddPlayerStats(player)
    AddLeaderStats(player)
end)
