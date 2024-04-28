local Coins = require(script.Parent.Coins)

local module = {}

function module.Initialize()
    game.Players.PlayerAdded:Connect(function(player)
        Coins.Initialize(player)
    end)
end

return module