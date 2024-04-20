local module = {}

local debounce = false

function module.TouchDoor(touchee, target)
	local hrp = touchee.Parent:FindFirstChild("HumanoidRootPart")
	if touchee.Parent:FindFirstChild("Humanoid") and hrp and debounce == false then
		debounce = true
        target:Destroy()
		debounce = false
	end
end

return module
