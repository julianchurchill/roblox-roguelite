local module = {}

local connections = require(script.Parent.Connections)

local function TouchDoor(_, door, darknessPart)
	darknessPart.Transparency = 1
	door:Destroy()
	return 'TARGET_DESTROYED'
end

function module.AddRemoveDarknessBehaviourTo(doorway)
	local darknessPart = doorway.DarknessPart.Value
	connections.SetupTouchedConnectionWithHRPCheckAndDebounce(
		doorway.door,
		function(touchee, target)
			return TouchDoor(touchee, target, darknessPart)
		end
	)
end

return module
