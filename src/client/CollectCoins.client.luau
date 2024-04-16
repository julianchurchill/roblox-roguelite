local debounce = false

function TouchCoin(touchee, target)
	local hrp = touchee.Parent:FindFirstChild("HumanoidRootPart")
	if touchee.Parent:FindFirstChild("Humanoid") and hrp and debounce == false then
		debounce = true
		local player = game.Players:GetPlayerFromCharacter(touchee.Parent)
		local playerStats = player:FindFirstChild("PlayerStats")
		local coins = playerStats:FindFirstChild("Coins")
		coins.Value += 1
		target:Destroy()
		debounce = false
	end
end

function SetupTouchedConnection(target, touchedFunction)
	local connection = nil
	connection = target.Touched:Connect(function(touchee)
		local result = touchedFunction(touchee, target)
		if result then
			connection:Disconnect()
		end
	end)
end

SetupTouchedConnection(game.Workspace.Dungeon.RightRoom.Coin, TouchCoin)
