local module = {}

local connections = require(script.Parent.Connections)
local addCoinsFn = game.ReplicatedStorage.Shared.AddCoinsFn

local function TouchCoin(_, target)
    if addCoinsFn:InvokeServer(1, target) == 'SUCCESS' then
        target:Destroy()
        return 'TARGET_DESTROYED'
    end
    return "TARGET_NOT_DESTROYED"
end

function module.AddCollectBehaviourTo(object)
    connections.SetupTouchedConnectionWithHRPCheckAndDebounce(object, TouchCoin)
end

return module
