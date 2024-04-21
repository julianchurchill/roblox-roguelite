local module = {}

local connections = require(script.Parent.Connections)
local damageIndicators = require(script.Parent.DamageIndicators)

function module.AddAttackableBehaviourTo(attackableTarget)
    local humanoid = attackableTarget:FindFirstChildWhichIsA("Humanoid")
    local humanoidRootPart = attackableTarget:WaitForChild("HumanoidRootPart")
    connections.SetupTouchedConnectionWithHRPCheckAndDebounce(
        humanoid,
        function(_, targetHumanoid)
            -- attack speed
            local damage = 1
            targetHumanoid:TakeDamage(damage)
            damageIndicators.ShowEnemyDamageIndicatorAsync(humanoidRootPart.CFrame, damage)
            -- auto attack based on proximity rather than having to hold a direction key
        end
    )
end

return module