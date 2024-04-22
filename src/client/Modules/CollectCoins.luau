local module = {}

local connections = require(script.Parent.Connections)
local addCoinsFn = game.ReplicatedStorage.Shared.AddCoinsFn

local function TouchCoin(_, target)
    addCoinsFn:InvokeServer(1)
    target:Destroy()
    return 'TARGET_DESTROYED'
end

function module.AddCollectBehaviourTo(object)
    connections.SetupTouchedConnectionWithHRPCheckAndDebounce(object, TouchCoin)
end

return module
