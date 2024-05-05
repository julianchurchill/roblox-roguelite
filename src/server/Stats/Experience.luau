local module = {}

local addExperienceRemoteFn = game.ReplicatedStorage.Shared:WaitForChild("AddExperienceRemoteFn")
local DataStoreService = require(script.Parent.Parent.DataStoreServiceWrapper)
local DataStoreUtils = require(script.Parent.Parent.Modules.DataStoreUtils)
local StatsDataStore = DataStoreService:GetDataStore("Stats")
local ExperienceChangedEvent = game.ReplicatedStorage.Shared:WaitForChild("ExperienceChangedEvent")

local experienceDataStoreKey = "Experience"
local defaultExperience = 0

function module.GetCurrentExperience(Player)
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
        return module.GetCurrentExperience(Player)
    end
end

function AddExperienceServerInvoke()
    addExperienceRemoteFn.OnServerInvoke = function(player, amountOfExperienceToAdd, experienceGiver)
                return currentExperience + amountOfExperienceToAdd
            end)
            return "SUCCESS"
    end
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

function module.ExperienceChangedEventConnect(func)
    ExperienceChangedEvent.Event:Connect(func)
end

function module.Initialize(Player)
    if module.GetCurrentExperience(Player) == nil then
        SetCurrentExperience(Player, defaultExperience)
    end
    AddExperienceServerInvoke()
end

return module