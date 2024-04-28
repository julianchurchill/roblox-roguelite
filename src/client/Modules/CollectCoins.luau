local module = {}

local connections = require(script.Parent.Connections)
local addCoinsRemoteFn = game.ReplicatedStorage.Shared:WaitForChild("AddCoinsRemoteFn")

local function TouchCoin(_, target)
    if addCoinsRemoteFn:InvokeServer(1, target) == 'SUCCESS' then
        target:Destroy()
        return 'TARGET_DESTROYED'
    end
    return "TARGET_NOT_DESTROYED"
end

function module.AddCollectBehaviourTo(object)
    connections.SetupTouchedConnectionWithHRPCheckAndDebounce(object, TouchCoin)
end

return module
