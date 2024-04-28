local Inventory = require(script.PlayerInventory.Inventory)

print("Hello world, from init.server.luau!")

Inventory.Initialize()

local behaviour = require(script.Modules.Behaviour)
local attack = require(script.Modules.Attack)

behaviour.SetupBehaviour("Attackable", attack.AddAttackableBehaviourTo)

