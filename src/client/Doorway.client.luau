local connections = require(script.Parent.Modules.Connections)

local debounce = false

function TouchDoor(touchee, target)
	local hrp = touchee.Parent:FindFirstChild("HumanoidRootPart")
	if touchee.Parent:FindFirstChild("Humanoid") and hrp and debounce == false then
		debounce = true
        target:Destroy()
		debounce = false
	end
end

connections.SetupTouchedConnection(game.Workspace.Dungeon.LeftRoom.WoodenDoorway.door, TouchDoor)
