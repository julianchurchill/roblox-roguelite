local module = {}

local connections = require(script.Parent.Connections)

function module.AddAttackableBehaviour(attackableTarget)
    connections.SetupTouchedConnectionWithHRPCheckAndDebounce(
        attackableTarget,
        function(touchee, target)
            print(touchee.Parent.Name .. " hit " .. target.Parent.Name)
        end
    )
end

return module