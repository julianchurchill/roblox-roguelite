local camera = game.Workspace:WaitForChild("Camera")
local char = script.Parent or game.Players.LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local distance = 20

local minDistance = 5
local maxDistance = 30

local RunService = game:GetService("RunService")

camera.CameraType = Enum.CameraType.Scriptable
RunService.RenderStepped:Connect(function()
    camera.CFrame = CFrame.new(hrp.Position + (hrp.CFrame.UpVector * distance)) * CFrame.Angles(math.rad(-70), 0, 0)
end)

local mouse = game.Players.LocalPlayer:GetMouse()

mouse.WheelForward:Connect(function()
	if distance > minDistance then
		distance -= 1
	end
end)
mouse.WheelBackward:Connect(function()
	if distance < maxDistance then
		distance += 1
	end
end)
