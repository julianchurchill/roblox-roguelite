local module = {}

function module.StartGUIUpdateLoop()
	local Player = game.Players.LocalPlayer
	local PlayerGui = Player:WaitForChild("PlayerGui")
	local CoinsLabel = PlayerGui:WaitForChild("ScreenGui"):WaitForChild("CoinsLabel")

	while task.wait() do
		CoinsLabel.Text = " Coins: " .. Player.PlayerStats.Coins.Value
	end
end

return module
