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
