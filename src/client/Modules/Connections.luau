local module = {}

function module.SetupTouchedConnection(target, touchedFunction)
	local connection = nil
	connection = target.Touched:Connect(function(touchee)
		local result = touchedFunction(touchee, target)
		if result then
			connection:Disconnect()
		end
	end)
end

return module