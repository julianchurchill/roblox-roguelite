local module = {}

function module.SetupTouchedConnectionWithHRPCheckAndDebounce(target, touchedFunction)
	local debounce = false
	local connection = nil
	connection = target.Touched:Connect(function(touchee)
		local humanoidRootPart = touchee.Parent:FindFirstChild("HumanoidRootPart")
		if touchee.Parent:FindFirstChild("Humanoid") and humanoidRootPart and debounce == false then
			debounce = true
			local status = touchedFunction(touchee, target)
			if status == 'TARGET_DESTROYED' then
				connection:Disconnect()
			end
			debounce = false
		end
	end)
end

return module