local Experience = require(script.Parent.Experience)

local module = {}

function module.Initialize()
    game.Players.PlayerAdded:Connect(function(player)
        Experience.Initialize(player)
    end)
end

return module