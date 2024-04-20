local connections = require(script.Parent.Modules.Connections)
local collectCoins = require(script.Parent.Modules.CollectCoins)
local doorway = require(script.Parent.Modules.Doorway)

connections.SetupTouchedConnection(game.Workspace.Dungeon.RightRoom.Coin, collectCoins.TouchCoin)
connections.SetupTouchedConnection(game.Workspace.Dungeon.LeftRoom.WoodenDoorway.door, doorway.TouchDoor)
