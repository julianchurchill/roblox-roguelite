local Coins = require(script.Parent.PlayerInventory.Coins)

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

    -- TODO: use a bindable event from Coins.SetCurrentCoins and Coins.UpdateCoins to update coins.Value in playerStats
end)
