print("Hello world, from init.client.luau!")

local behaviour = require(script.Modules.Behaviour)
local collectCoins = require(script.Modules.CollectCoins)
local doorway = require(script.Modules.Doorway)
local kill = require(script.Modules.Kill)
local keyboard = require(script.Modules.Keyboard)
local GUIUpdateLoop = require(script.GUI.GUIUpdateLoop)
local damageIndicators = require(script.Modules.DamageIndicators)

behaviour.SetupBehaviour("CollectableCoin", collectCoins.AddCollectBehaviourTo)
behaviour.SetupBehaviour("OpenableDoorway", doorway.AddRemoveDarknessBehaviourTo)
behaviour.SetupBehaviour("Killable", kill.AddKillableBehaviourTo)

keyboard.RegisterKeyActions()

GUIUpdateLoop.StartGUIUpdateLoop()

damageIndicators.SetupHumanoidDamageIndicators()
