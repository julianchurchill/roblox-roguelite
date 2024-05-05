local module = {}

local DataStoreService = require(script.Parent.Parent.DataStoreServiceWrapper)
local DataStoreUtils = require(script.Parent.Parent.Modules.DataStoreUtils)
local StatsDataStore = DataStoreService:GetDataStore("Stats")
local LevelChangedEvent = game.ReplicatedStorage.Shared:WaitForChild("LevelChangedEvent")

local levelDataStoreKey = "Level"
local defaultLevel = 1

function module.GetCurrentValue(Player)
    local success, result = pcall(function()
        return StatsDataStore:GetAsync(DataStoreUtils.MakeDataStoreKeyForPlayer(Player, levelDataStoreKey))
    end)
    if success then
        return result
    else
        print("Error getting level: " .. result)
        return defaultLevel
    end
end

local function UpdateLevel(Player, UpdateFunc)
    local success, result = pcall(function()
        return StatsDataStore:UpdateAsync(DataStoreUtils.MakeDataStoreKeyForPlayer(Player, levelDataStoreKey), UpdateFunc)
    end)
    if success then
        LevelChangedEvent:Fire(result)
        print("Level updated to: " .. result)
        return result
    else
        print("Error updating level: " .. result)
        return module.GetCurrentValue(Player)
    end
end

function module.AddLevels(player, numberOfLevelsToAdd)
    UpdateLevel(player, function(currentLevel)
        return currentLevel + numberOfLevelsToAdd
    end)
end

function SetCurrentLevel(Player, level)
    local success, result = pcall(function()
        return StatsDataStore:SetAsync(DataStoreUtils.MakeDataStoreKeyForPlayer(Player, levelDataStoreKey), level)
    end)
    if success then
        LevelChangedEvent:Fire(level)
        print("Level set to: " .. level)
    else
        print("Error setting level: " .. result)
    end
end

function module.ChangedEventConnect(func)
    LevelChangedEvent.Event:Connect(func)
end

function module.Initialize(Player)
    if module.GetCurrentValue(Player) == nil then
        SetCurrentLevel(Player, defaultLevel)
    end
end

return module