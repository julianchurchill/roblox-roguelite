local Coins = require(script.Parent.PlayerInventory.Coins)
local CoinsChangedEvent = game.ReplicatedStorage.Shared:WaitForChild("CoinsChangedEvent")

game.Players.PlayerAdded:Connect(function(player)
    local playerStats = Instance.new("Folder")
    playerStats.Parent = player;
    playerStats.Name = "PlayerStats"

    local coins = Instance.new("NumberValue")
    coins.Parent = playerStats;
    coins.Name = "Coins"
    local currentCoins = Coins.GetCurrentCoins(player)
    if currentCoins == nil then
        coins.Value = 0
    else
        coins.Value = currentCoins
    end

    CoinsChangedEvent.Event:Connect(function(newCoins)
        coins.Value = newCoins
    end)
end)
