local connections = require(script.Parent.Connections)

local module = {}

local function TouchDoor(_, door, darknessPart)
	darknessPart.Transparency = 1
	door:Destroy()
end

function module.InitializeDoorway(doorway, darknessPart)
	connections.SetupTouchedConnectionWithHRPCheckAndDebounce(
		doorway.door,
		function(touchee, target)
			TouchDoor(touchee, target, darknessPart)
		end
	)
end

return module
