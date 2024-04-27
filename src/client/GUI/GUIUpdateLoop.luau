local module = {}

function module.StartGUIUpdateLoop()
	task.spawn(function()
		local Player = game.Players.LocalPlayer
		local PlayerGui = Player:WaitForChild("PlayerGui")
		local CoinsLabel = PlayerGui:WaitForChild("ScreenGui"):WaitForChild("CoinsLabel")
		local PlayerStats = Player:WaitForChild("PlayerStats")
		local Coins = PlayerStats:WaitForChild("Coins")

		while task.wait() do
			CoinsLabel.Text = " Coins: " .. Coins.Value
		end
	end)
end

return module
