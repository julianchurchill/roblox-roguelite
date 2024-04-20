local module = {}

function module.RegisterKeyActions()
    local uis = game:GetService("UserInputService")
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local dashDebounce = false

    local dashSpeedIncrease = 24
    local dashDurationSeconds = 0.5
    local dashCooldownSeconds = 0.3

    uis.InputBegan:Connect(function(key, processed)
        if processed then
            return
        end

        if dashDebounce == false and key.KeyCode == Enum.KeyCode.Space then
            dashDebounce = true
            humanoid.WalkSpeed += dashSpeedIncrease
            task.wait(dashDurationSeconds)
            humanoid.WalkSpeed -= dashSpeedIncrease
            task.wait(dashCooldownSeconds)
            dashDebounce = false
        end
    end)
end

return module
