local module = {}

local addCoinsEvent = game.ReplicatedStorage.Shared.AddCoins

function module.TouchCoin(_, target)
	addCoinsEvent:FireServer(1)
	target:Destroy()
	return 'TARGET_DESTROYED'
end

return module
