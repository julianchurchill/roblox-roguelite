local module = {}

local connections = require(script.Parent.Connections)
local damageIndicators = require(script.Parent.DamageIndicators)

local attackDamage = 1
local attacksPerSecond = 1

function module.AddAttackableBehaviourTo(attackableTarget)
    local humanoid = attackableTarget:FindFirstChildWhichIsA("Humanoid")
    local humanoidRootPart = attackableTarget:WaitForChild("HumanoidRootPart")
    connections.SetupTouchedConnectionWithHRPCheckAndDebounce(
        humanoid,
        function(_, targetHumanoid)
            local damage = attackDamage
            targetHumanoid:TakeDamage(damage)
            damageIndicators.ShowEnemyDamageIndicatorAsync(humanoidRootPart.CFrame, damage)
            -- delay completion of attack to account for attack speed
            task.wait(1/attacksPerSecond)
        end
    )
end

return module