print("Hello world, from init.client.luau!")

local connections = require(script.Modules.Connections)
local collectCoins = require(script.Modules.CollectCoins)
local doorway = require(script.Modules.Doorway)
local keyboard = require(script.Modules.Keyboard)
local GUIUpdateLoop = require(script.GUI.GUIUpdateLoop)

connections.SetupTouchedConnectionWithHRPCheckAndDebounce(game.Workspace.Dungeon.RightRoom.Coin, collectCoins.TouchCoin)

doorway.InitializeDoorway(game.Workspace.Dungeon.LeftRoom.WoodenDoorway, game.Workspace.Dungeon.LeftRoom.Darkness)

keyboard.RegisterKeyActions()

GUIUpdateLoop.StartGUIUpdateLoop()
