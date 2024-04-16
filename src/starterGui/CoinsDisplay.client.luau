local Player = game.Players.LocalPlayer

while task.wait() do
	script.Parent.ScreenGui.CoinsLabel.Text = " Coins: " .. Player.PlayerStats.Coins.Value
end