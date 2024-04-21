local module = {}

local connections = require(script.Parent.Connections)
local damageIndicators = require(script.Parent.DamageIndicators)

local function InRange(part1, part2, maxDistance)
    local distance = (part1.Position - part2.Position).Magnitude
    return distance <= maxDistance
end

local attackRange = 6
local attackDamage = 1
local attacksPerSecond = 1

local function AttackUntilOutOfRange(targetHumanoid, targetHumanoidRootPart, attacker)
    local attackerHumanoidRootPart = attacker:WaitForChild("HumanoidRootPart")
    while InRange(targetHumanoidRootPart, attackerHumanoidRootPart, attackRange) do
        local damage = attackDamage
        targetHumanoid:TakeDamage(damage)
        damageIndicators.ShowEnemyDamageIndicatorAsync(targetHumanoidRootPart.CFrame, damage)
        -- delay completion of attack to account for attack speed
        task.wait(1/attacksPerSecond)
    end
end

function module.AddAttackableBehaviourTo(attackableTarget)
    local humanoid = attackableTarget:FindFirstChildWhichIsA("Humanoid")
    local targetHumanoidRootPart = attackableTarget:WaitForChild("HumanoidRootPart")
    connections.SetupTouchedConnectionWithHRPCheckAndDebounce(
        humanoid,
        function(toucheePart, targetHumanoid)
            -- possibility of already attacking is dealt with by debounce in 'connections' event handling
            AttackUntilOutOfRange(targetHumanoid, targetHumanoidRootPart, toucheePart.Parent)
            return 'TARGET_NOT_DESTROYED'
        end
    )
end

return module