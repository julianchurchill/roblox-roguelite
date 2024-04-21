local module = {}

local connections = require(script.Parent.Connections)
local addCoinsEvent = game.ReplicatedStorage.Shared.AddCoins

local function TouchCoin(_, target)
    addCoinsEvent:FireServer(1)
    target:Destroy()
    return 'TARGET_DESTROYED'
end

function module.AddCollectBehaviourTo(object)
    connections.SetupTouchedConnectionWithHRPCheckAndDebounce(object, TouchCoin)
end

return module
