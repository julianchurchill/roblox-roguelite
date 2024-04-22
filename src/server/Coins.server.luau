local addCoinsFn = game.ReplicatedStorage.Shared.AddCoinsFn

addCoinsFn.OnServerInvoke = function(player, numberOfCoinsToAdd)
	local playerStats = player:FindFirstChild("PlayerStats")
	local coins = playerStats:FindFirstChild("Coins")
	coins.Value += numberOfCoinsToAdd
end