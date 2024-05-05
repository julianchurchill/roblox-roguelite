local Coins = require(script.Parent.PlayerInventory.Coins)
local Experience = require(script.Parent.Stats.Experience)
local Level = require(script.Parent.Stats.Level)

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

local defaultCoins = 0
local defaultExperience = 0
local defaultLevel = 1

local function AddPlayerStats(player)
    local playerStats = Instance.new("Folder")
    playerStats.Parent = player;
    playerStats.Name = "PlayerStats"

    AddStat(playerStats, defaultCoins, "Coins", Coins, player)
    AddStat(playerStats, defaultExperience, "Experience", Experience, player)
    AddStat(playerStats, defaultLevel, "Level", Level, player)
end

local function AddLeaderStats(player)
    local leaderStats = Instance.new("Folder")
    leaderStats.Parent = player;
    leaderStats.Name = "leaderstats"

    AddStat(leaderStats, defaultCoins, "Coins", Coins, player)
    AddStat(leaderStats, defaultLevel, "Level", Level, player)
end

game.Players.PlayerAdded:Connect(function(player)
    AddPlayerStats(player)
    AddLeaderStats(player)
end)
