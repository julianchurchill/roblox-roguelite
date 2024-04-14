local camera = game.Workspace:WaitForChild("Camera")
local char = script.Parent or game.Players.LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local initialCameraDistance = 20
local currentCameraDistance = initialCameraDistance

local minCameraDistance = 15
local maxCameraDistance = 30

local function CameraWithAngleChangeAsYouZoom()
	local minCameraAngleRadians = 65
	local maxCameraAngleRadians = 85

	local backCameraOffset = Vector3.new(0, 0, 5);
	local upCameraOffset = hrp.CFrame.UpVector * currentCameraDistance;
	local distanceAsProportionOfFullDistance = (currentCameraDistance - minCameraDistance) / (maxCameraDistance - minCameraDistance);
	local cameraAngleRange = maxCameraAngleRadians - minCameraAngleRadians;
	local cameraAngleInRadians = minCameraAngleRadians + cameraAngleRange * distanceAsProportionOfFullDistance;
	local cameraAngle = CFrame.Angles(math.rad(-cameraAngleInRadians), 0, 0);
    camera.CFrame = CFrame.new(hrp.Position + upCameraOffset + backCameraOffset) * cameraAngle
end

-- Set mouse wheel behaviour
local mouse = game.Players.LocalPlayer:GetMouse()

mouse.WheelForward:Connect(function()
	if currentCameraDistance > minCameraDistance then
		currentCameraDistance -= 1
	end
end)

mouse.WheelBackward:Connect(function()
	if currentCameraDistance < maxCameraDistance then
		currentCameraDistance += 1
	end
end)

-- Set camera behaviour
local RunService = game:GetService("RunService")

camera.CameraType = Enum.CameraType.Scriptable
RunService.RenderStepped:Connect(CameraWithAngleChangeAsYouZoom)
