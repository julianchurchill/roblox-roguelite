local connections = require(script.Parent.Connections)

local module = {}

local function TouchDoor(_, door, darknessPart)
	darknessPart.Transparency = 1
	door:Destroy()
	return true
end

function module.InitializeDoorway(doorway, darknessPart)
	connections.SetupTouchedConnectionWithHRPCheckAndDebounce(
		doorway.door,
		function(touchee, target)
			return TouchDoor(touchee, target, darknessPart)
		end
	)
end

return module
