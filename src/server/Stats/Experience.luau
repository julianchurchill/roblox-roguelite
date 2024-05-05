local module = {}

local DataStoreService = require(script.Parent.Parent.DataStoreServiceWrapper)
local DataStoreUtils = require(script.Parent.Parent.Modules.DataStoreUtils)
local StatsDataStore = DataStoreService:GetDataStore("Stats")
local ExperienceChangedEvent = game.ReplicatedStorage.Shared:WaitForChild("ExperienceChangedEvent")

local experienceDataStoreKey = "Experience"
local defaultExperience = 0

function module.GetCurrentValue(Player)
    local success, result = pcall(function()
        return StatsDataStore:GetAsync(DataStoreUtils.MakeDataStoreKeyForPlayer(Player, experienceDataStoreKey))
    end)
    if success then
        return result
    else
        print("Error getting experience: " .. result)
        return defaultExperience
    end
end

local function UpdateExperience(Player, UpdateFunc)
    local success, result = pcall(function()
        return StatsDataStore:UpdateAsync(DataStoreUtils.MakeDataStoreKeyForPlayer(Player, experienceDataStoreKey), UpdateFunc)
    end)
    if success then
        ExperienceChangedEvent:Fire(result)
        print("Experience updated to: " .. result)
        return result
    else
        print("Error updating experience: " .. result)
        return module.GetCurrentValue(Player)
    end
end

function module.AddExperience(player, amountOfExperienceToAdd)
    UpdateExperience(player, function(currentExperience)
        return currentExperience + amountOfExperienceToAdd
    end)
end

function SetCurrentExperience(Player, experience)
    local success, result = pcall(function()
        return StatsDataStore:SetAsync(DataStoreUtils.MakeDataStoreKeyForPlayer(Player, experienceDataStoreKey), experience)
    end)
    if success then
        ExperienceChangedEvent:Fire(experience)
        print("Experience set to: " .. experience)
    else
        print("Error setting experience: " .. result)
    end
end

function module.ChangedEventConnect(func)
    ExperienceChangedEvent.Event:Connect(func)
end

function module.Initialize(Player)
    if module.GetCurrentValue(Player) == nil then
        SetCurrentExperience(Player, defaultExperience)
    end
end

return module