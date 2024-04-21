print("Hello world, from init.client.luau!")

local behaviour = require(script.Modules.Behaviour)
local collectCoins = require(script.Modules.CollectCoins)
local attack = require(script.Modules.Attack)
local doorway = require(script.Modules.Doorway)
local keyboard = require(script.Modules.Keyboard)
local GUIUpdateLoop = require(script.GUI.GUIUpdateLoop)

behaviour.SetupBehaviour("CollectableCoin", collectCoins.AddCollectBehaviourTo)
behaviour.SetupBehaviour("Attackable", attack.AddAttackableBehaviourTo)

doorway.InitializeDoorway(game.Workspace.Dungeon.LeftRoom.WoodenDoorway, game.Workspace.Dungeon.LeftRoom.Darkness)

keyboard.RegisterKeyActions()

GUIUpdateLoop.StartGUIUpdateLoop()
