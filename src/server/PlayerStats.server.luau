local Coins = require(script.Parent.PlayerInventory.Coins)
local Experience = require(script.Parent.Stats.Experience)

game.Players.PlayerAdded:Connect(function(player)
    local playerStats = Instance.new("Folder")
    playerStats.Parent = player;
    playerStats.Name = "PlayerStats"

    local coinsDefault = 0
    local coins = Instance.new("NumberValue")
    coins.Parent = playerStats;
    coins.Name = "Coins"
    local currentCoins = Coins.GetCurrentCoins(player)
    if currentCoins == nil then
        coins.Value = coinsDefault
    else
        coins.Value = currentCoins
    end

    Coins.CoinsChangedEventConnect(function(newCoins)
        coins.Value = newCoins
    end)

    local experienceDefault = 0
    local experience = Instance.new("NumberValue")
    experience.Parent = playerStats;
    experience.Name = "Experience"
    local currentExperience = Experience.GetCurrentExperience(player)
    if currentExperience == nil then
        experience.Value = experienceDefault
    else
        experience.Value = currentExperience
    end

    Experience.ExperienceChangedEventConnect(function(newExperience)
        experience.Value = newExperience
    end)
end)
