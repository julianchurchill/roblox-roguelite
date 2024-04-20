local connections = require(script.Parent.Connections)

local module = {}

function module.InitializeDoorway(doorway, darknessPart)
	connections.SetupTouchedConnectionWithHRPCheckAndDebounce(
		doorway.door,
		function(touchee, target)
			TouchDoor(touchee, target, darknessPart)
		end
	)
end

function TouchDoor(_, door, darknessPart)
	darknessPart.Transparency = 1
	door:Destroy()
end

return module
