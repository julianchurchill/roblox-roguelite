local module = {}

local connections = require(script.Parent.Connections)

function module.AddKillableBehaviourTo(killableTarget)
    local killableHumanoid = killableTarget:FindFirstChildWhichIsA("Humanoid")
    connections.SetupDiedConnectionWithHRPCheckAndDebounce(
        killableHumanoid,
        function(killedHumanoid)
            local attackerPlayer = killableHumanoid:FindFirstChild("AttackerPlayer")
            if attackerPlayer then
                local killer = attackerPlayer.Value
                print(killedHumanoid.Name .. ' was killed by ' .. killer.Name)
            else
                print(killedHumanoid.Name .. ' was killed by an unknown force')
            end
            -- Destroy animation?
            killedHumanoid.Parent:Destroy()
            return 'TARGET_DESTROYED'
            -- return 'TARGET_NOT_DESTROYED'
        end
    )
end

return module