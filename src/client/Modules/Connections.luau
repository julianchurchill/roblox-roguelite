local module = {}

function module.SetupTouchedConnectionWithHRPCheckAndDebounce(targetHumanoidOrPart, touchedFunction)
	local debounce = false
	local connection = nil
	connection = targetHumanoidOrPart.Touched:Connect(function(toucheePart)
		local humanoidRootPart = toucheePart.Parent:FindFirstChild("HumanoidRootPart")
		if toucheePart.Parent:FindFirstChild("Humanoid") and humanoidRootPart and debounce == false then
			debounce = true
			local status = touchedFunction(toucheePart, targetHumanoidOrPart)
			if status == 'TARGET_DESTROYED' then
				connection:Disconnect()
			end
			debounce = false
		end
	end)
end

function module.SetupDiedConnectionWithHRPCheckAndDebounce(killedHumanoid, diedFunction)
	local debounce = false
	local connection = nil
	connection = killedHumanoid.Died:Connect(function()
		local humanoidRootPart = killedHumanoid.Parent:FindFirstChild("HumanoidRootPart")
		if killedHumanoid.Parent:FindFirstChild("Humanoid") and humanoidRootPart and debounce == false then
			debounce = true
			local status = diedFunction(killedHumanoid)
			if status == 'TARGET_DESTROYED' then
				connection:Disconnect()
			end
			debounce = false
		end
	end)
end

return module