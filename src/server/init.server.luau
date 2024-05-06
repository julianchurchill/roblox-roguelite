local Workspace = game:GetService("Workspace")
local Inventory = require(script.PlayerInventory.Inventory)
local Stats = require(script.Stats.Stats)

print("Hello world, from init.server.luau!")

Inventory.Initialize()
Stats.Initialize()

local behaviour = require(script.Modules.Behaviour)
local attack = require(script.Modules.Attack)
local kill = require(script.Modules.Kill)

behaviour.SetupBehaviour("Attackable", attack.AddAttackableBehaviourTo)
behaviour.SetupBehaviour("Killable", kill.AddKillableBehaviourTo)

local minAmount = 1
local maxAmount = 10
local name = "Worm"
local spawnRate = 0.5
local monsterEntry = {}
monsterEntry.minAmount = minAmount
monsterEntry.maxAmount = maxAmount
monsterEntry.name = name
monsterEntry.spawnRate = spawnRate
monsterEntry.modelTemplate = Workspace.Templates.Worm

local availableMonsterList = {}
table.insert(availableMonsterList, monsterEntry)

local function PopulateMonsters(spawnableAreas, monsterList)
	for _, monster in pairs(monsterList) do
        print("Monster found: " .. monster.name)
        for _, spawnableArea in pairs(spawnableAreas) do
            print("Spawning in area " .. spawnableArea.Parent.name .. " with position "
             .. spawnableArea.Position.X .. ", " .. spawnableArea.Position.Y .. ", " .. spawnableArea.Position.Z
             .. " and size "
             .. spawnableArea.Size.X .. ", " .. spawnableArea.Size.Y .. ", " .. spawnableArea.Size.Z)

             -- spawn min monsters
             for _ = 1, monster.minAmount do
                local newMonsterModel = monster.modelTemplate:Clone()
                newMonsterModel.Parent = spawnableArea.Parent
                local xOffset = 0
                local zOffset = 0
                local upALittleBit = Vector3.new(xOffset, 1, zOffset)
                local newMonsterCFrame = spawnableArea.CFrame + upALittleBit
                newMonsterModel:SetPrimaryPartCFrame(newMonsterCFrame)
             end
    end
end

local candidateSpawnableAreas = {}
table.insert(candidateSpawnableAreas, Workspace.Dungeon.LeftRoom.SpawnArea)
table.insert(candidateSpawnableAreas, Workspace.Dungeon.RightRoom.SpawnArea)
PopulateMonsters(candidateSpawnableAreas, availableMonsterList)
