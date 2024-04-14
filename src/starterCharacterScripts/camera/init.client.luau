local camera = game.Workspace:WaitForChild("Camera")
local char = script.Parent or game.Players.LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")


local function CameraWithFixedAngleAndDistance()
	local fixedCameraDistance = 35;
	local positionCameraOffset = Vector3.new(0, 0, 15);
	local upCameraOffset = hrp.CFrame.UpVector * fixedCameraDistance;
	local cameraAngle = CFrame.Angles(math.rad(-60), 0, 0);
    camera.CFrame = CFrame.new(hrp.Position + upCameraOffset + positionCameraOffset) * cameraAngle
end

-- local initialCameraDistance = 20
-- local currentCameraDistanceForAdaptiveCamera = initialCameraDistance

-- local minCameraDistanceForAdaptiveCamera = 15
-- local maxCameraDistanceForAdaptiveCamera = 30

-- local function CameraWithAngleChangeAsYouZoom()
-- 	local minCameraAngleRadians = 65
-- 	local maxCameraAngleRadians = 85

-- 	local backCameraOffset = Vector3.new(0, 0, 5);
-- 	local upCameraOffset = hrp.CFrame.UpVector * currentCameraDistanceForAdaptiveCamera;
-- 	local distanceAsProportionOfFullDistance = (currentCameraDistanceForAdaptiveCamera - minCameraDistanceForAdaptiveCamera) / (maxCameraDistanceForAdaptiveCamera - minCameraDistanceForAdaptiveCamera);
-- 	local cameraAngleRange = maxCameraAngleRadians - minCameraAngleRadians;
-- 	local cameraAngleInRadians = minCameraAngleRadians + cameraAngleRange * distanceAsProportionOfFullDistance;
-- 	local cameraAngle = CFrame.Angles(math.rad(-cameraAngleInRadians), 0, 0);
--     camera.CFrame = CFrame.new(hrp.Position + upCameraOffset + backCameraOffset) * cameraAngle
-- end

-- -- Set mouse wheel behaviour
-- local mouse = game.Players.LocalPlayer:GetMouse()

-- mouse.WheelForward:Connect(function()
-- 	if currentCameraDistanceForAdaptiveCamera > minCameraDistanceForAdaptiveCamera then
-- 		currentCameraDistanceForAdaptiveCamera -= 1
-- 	end
-- end)

-- mouse.WheelBackward:Connect(function()
-- 	if currentCameraDistanceForAdaptiveCamera < maxCameraDistanceForAdaptiveCamera then
-- 		currentCameraDistanceForAdaptiveCamera += 1
-- 	end
-- end)

-- Set camera behaviour
local RunService = game:GetService("RunService")

camera.CameraType = Enum.CameraType.Scriptable
-- RunService.RenderStepped:Connect(CameraWithAngleChangeAsYouZoom)
RunService.RenderStepped:Connect(CameraWithFixedAngleAndDistance)
