--[[
    LocalScript
    PlayerInput example
]]--

local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")

local shootRock = RS.RemoteEvents:WaitForChild("ShootRock")

local localPlayer = game.Players.LocalPlayer
local mouse = localPlayer:GetMouse()

UIS.InputBegan:Connect(function(input, processed)
	if not processed then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			shootRock:FireServer(mouse.Hit.p)
		end
	end
end)