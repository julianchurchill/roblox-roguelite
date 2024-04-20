local module = {}

function module.RegisterKeyActions()
    local uis = game:GetService("UserInputService")
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local debounce = false

    local dashSpeedIncrease = 16
    local dashDurationSeconds = 0.5
    local dashCooldownSeconds = 1

    uis.InputBegan:Connect(function(key, processed)
        if debounce or processed then
            return
        end

        if key.KeyCode == Enum.KeyCode.Space then
            debounce = true
            humanoid.WalkSpeed += dashSpeedIncrease
            task.wait(dashDurationSeconds)
            humanoid.WalkSpeed -= dashSpeedIncrease
        end

        task.wait(dashCooldownSeconds)
        debounce = false
    end)
end

return module
