local module = {}

function module.StartGUIUpdateLoop()
    task.spawn(function()
        local Player = game.Players.LocalPlayer
        local PlayerGui = Player:WaitForChild("PlayerGui")
        local CoinsLabel = PlayerGui:WaitForChild("ScreenGui"):WaitForChild("CoinsLabel")
        local XPBarContainer = PlayerGui:WaitForChild("ScreenGui"):WaitForChild("XPBarContainer")
        local LevelLabel = PlayerGui:WaitForChild("ScreenGui"):WaitForChild("LevelLabel")
        local PlayerStats = Player:WaitForChild("PlayerStats")
        local Coins = PlayerStats:WaitForChild("Coins")
        local Experience = PlayerStats:WaitForChild("Experience")
        local Level = PlayerStats:WaitForChild("Level")

        while task.wait() do
            CoinsLabel.Text = " Coins: " .. Coins.Value
            XPBarContainer.XPBar:TweenSize(UDim2.new(Experience.Value/10, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.15, true)
            XPBarContainer.XPLabel.Text = Experience.Value .. "/10"
            LevelLabel.Text = Level.Value
        end
    end)
end

return module
