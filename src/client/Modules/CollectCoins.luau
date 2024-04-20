local module = {}

local addCoinsEvent = game.ReplicatedStorage.Shared.AddCoins

function module.TouchCoin(_, target)
	addCoinsEvent:FireServer(1)
	target:Destroy()
end

return module
