game.Players.PlayerAdded:Connect(function(Player)
	local playerStats = Instance.new("Folder", Player)
	playerStats.Name = "PlayerStats"

	local coins = Instance.new("NumberValue", playerStats)
	coins.Name = "Coins"
	coins.Value = 0
end)
