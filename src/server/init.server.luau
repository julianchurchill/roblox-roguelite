local Inventory = require(script.PlayerInventory.Inventory)

print("Hello world, from init.server.luau!")

Inventory.Initialize()

local behaviour = require(script.Modules.Behaviour)
local attack = require(script.Modules.Attack)
local kill = require(script.Modules.Kill)

behaviour.SetupBehaviour("Attackable", attack.AddAttackableBehaviourTo)
behaviour.SetupBehaviour("Killable", kill.AddKillableBehaviourTo)
