print("Hello world, from init.client.luau!")

local connections = require(script.Modules.Connections)
local collectCoins = require(script.Modules.CollectCoins)
local doorway = require(script.Modules.Doorway)
local GUIUpdateLoop = require(script.GUI.GUIUpdateLoop)

connections.SetupTouchedConnectionWithHRPCheckAndDebounce(game.Workspace.Dungeon.RightRoom.Coin, collectCoins.TouchCoin)
connections.SetupTouchedConnectionWithHRPCheckAndDebounce(game.Workspace.Dungeon.LeftRoom.WoodenDoorway.door, doorway.TouchDoor)

GUIUpdateLoop.StartGUIUpdateLoop()
