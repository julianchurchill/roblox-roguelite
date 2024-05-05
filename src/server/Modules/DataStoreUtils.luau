local module = {}

function module.MakeDataStoreKeyForPlayer(player, identifier)
    return identifier .. "/" .. player.UserId
end

return module