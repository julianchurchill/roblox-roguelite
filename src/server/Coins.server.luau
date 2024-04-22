local addCoinsFn = game.ReplicatedStorage.Shared.AddCoinsFn

local function InRange(part1, part2, maxDistance)
    local distance = (part1.Position - part2.Position).Magnitude
    return distance <= maxDistance
end

local maxDistanceToCoins = 5

addCoinsFn.OnServerInvoke = function(player, numberOfCoinsToAdd, coin)
    if InRange(coin, player.Character:FindFirstChild("HumanoidRootPart"), maxDistanceToCoins) then
        local playerStats = player:FindFirstChild("PlayerStats")
        local coins = playerStats:FindFirstChild("Coins")
        coins.Value += numberOfCoinsToAdd
        return "SUCCESS"
    end
    return "FAILURE"
end