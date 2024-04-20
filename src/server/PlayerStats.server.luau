game.Players.PlayerAdded:Connect(function(Player)
	local playerStats = Instance.new("Folder")
    playerStats.Parent = Player;
	playerStats.Name = "PlayerStats"

	local coins = Instance.new("NumberValue")
    coins.Parent = playerStats;
	coins.Name = "Coins"
	coins.Value = 0
end)

local addCoinsEvent = game.ReplicatedStorage.Shared.AddCoins

addCoinsEvent.OnServerEvent:Connect(function(player, numberOfCoinsToAdd)
	local playerStats = player:FindFirstChild("PlayerStats")
	local coins = playerStats:FindFirstChild("Coins")
	coins.Value += numberOfCoinsToAdd
end)
