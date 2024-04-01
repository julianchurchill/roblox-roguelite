local camera = game.Workspace:WaitForChild("Camera")
local char = script.Parent or game.Players.LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local initialDistance = 20
local distance = initialDistance

local minDistance = 15
local maxDistance = 30

local minCameraAngleRadians = 65
local maxCameraAngleRadians = 85

local RunService = game:GetService("RunService")

camera.CameraType = Enum.CameraType.Scriptable
RunService.RenderStepped:Connect(function()
	local backCameraOffset = Vector3.new(0, 0, 5);
	local upCameraOffset = hrp.CFrame.UpVector * distance;
	local distanceAsProportionOfFullDistance = (distance - minDistance) / (maxDistance - minDistance);
	local cameraAngleRange = maxCameraAngleRadians - minCameraAngleRadians;
	local cameraAngleInRadians = minCameraAngleRadians + cameraAngleRange * distanceAsProportionOfFullDistance;
	local cameraAngle = CFrame.Angles(math.rad(-cameraAngleInRadians), 0, 0);
    camera.CFrame = CFrame.new(hrp.Position + upCameraOffset + backCameraOffset) * cameraAngle
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
