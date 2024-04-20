local module = {}

function module.TouchCoin(touchee, target)
	local player = game.Players:GetPlayerFromCharacter(touchee.Parent)
	local playerStats = player:FindFirstChild("PlayerStats")
	local coins = playerStats:FindFirstChild("Coins")
	coins.Value += 1
	target:Destroy()
end

return module
