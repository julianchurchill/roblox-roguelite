local module = {}

local Player = game.Players.LocalPlayer
local EnemyDamageIndicatorsScreenGui = Player.PlayerGui:WaitForChild("EnemyDamageIndicators")
local currentCamera = game.Workspace.CurrentCamera

local maxX = (EnemyDamageIndicatorsScreenGui.AbsoluteSize.X / 6)
local maxY = (EnemyDamageIndicatorsScreenGui.AbsoluteSize.Y / 6)

function ClampPositionToPlayersScreen(targetCFrame)
    local screenPosition = currentCamera:WorldToViewportPoint(targetCFrame.Position)
    local indicatorX = math.clamp(screenPosition.X, maxX, (EnemyDamageIndicatorsScreenGui.AbsoluteSize.X - maxX))
    local indicatorY = math.clamp(screenPosition.Y, maxY, (EnemyDamageIndicatorsScreenGui.AbsoluteSize.Y - maxY))
    return indicatorX, indicatorY
end

local fadeAmountX = 0
local fadeAmountY = 8
local fadeOutTween = Enum.EasingStyle.Quart
local fadeOutDurationSeconds = 0.4

function AnimateOutAndDestroy(element)
    element:TweenSizeAndPosition(
        element.Size,
        element.Position + UDim2.fromOffset(fadeAmountX, -fadeAmountY),
        Enum.EasingDirection.In,
        fadeOutTween,
        fadeOutDurationSeconds,
        true,
        function()
            element:Destroy()
        end
    )
end

local EnemyDamageIndicatorTemplate = EnemyDamageIndicatorsScreenGui.IndicatorTemplate
local EnemyDamageIndicatorsHome = EnemyDamageIndicatorsScreenGui.Indicators

local indicatorOffsetX = 10;
local indicatorOffsetY = -120;
local indicatorOffsetVariation = 20;
local indicatorShowForSeconds = 0.25

-- Based on https://devforum.roblox.com/t/how-to-implement-a-damage-indication-system/483161
function ShowEnemyDamageIndicatorAsync(targetCFrame, number)
    task.spawn(
        function()
            local indicatorX, indicatorY = ClampPositionToPlayersScreen(targetCFrame)

            local numberIndicator = EnemyDamageIndicatorTemplate:Clone()
            numberIndicator.Name = "Indicator"
            numberIndicator.Visible = true
            numberIndicator.Shadow.Visible = true

            numberIndicator.Position = UDim2.new(
                0, indicatorX + indicatorOffsetX + math.random(-indicatorOffsetVariation, indicatorOffsetVariation),
                0, (indicatorY + indicatorOffsetY + math.random(-indicatorOffsetVariation, indicatorOffsetVariation)))
            numberIndicator.Parent = EnemyDamageIndicatorsHome

            numberIndicator.Text = tostring(number)
            numberIndicator.Shadow.Text = numberIndicator.Text

            task.wait(indicatorShowForSeconds)
            AnimateOutAndDestroy(numberIndicator)
        end
    )
end

local HumanoidDamagedRemoteEvent = game.ReplicatedStorage.Shared:WaitForChild("HumanoidDamagedRemoteEvent")

function module.SetupHumanoidDamageIndicators()
    HumanoidDamagedRemoteEvent.OnClientEvent:Connect(function(targetHumanoidRootPart, damage)
        ShowEnemyDamageIndicatorAsync(targetHumanoidRootPart.CFrame, damage)
    end)
end

return module