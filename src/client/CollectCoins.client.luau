local connections = require(script.Parent.Modules.Connections)

local debounce = false

function TouchCoin(touchee, target)
	local hrp = touchee.Parent:FindFirstChild("HumanoidRootPart")
	if touchee.Parent:FindFirstChild("Humanoid") and hrp and debounce == false then
		debounce = true
		local player = game.Players:GetPlayerFromCharacter(touchee.Parent)
		local playerStats = player:FindFirstChild("PlayerStats")
		local coins = playerStats:FindFirstChild("Coins")
		coins.Value += 1
		target:Destroy()
		debounce = false
	end
end

connections.SetupTouchedConnection(game.Workspace.Dungeon.RightRoom.Coin, TouchCoin)
