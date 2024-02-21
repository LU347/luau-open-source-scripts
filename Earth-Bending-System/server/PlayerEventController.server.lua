--[[
    Server Script that handles incoming client remote events
]]--

local RS = game:GetService("ReplicatedStorage")
local Earth = require(RS.Shared:WaitForChild("Earth")) -- Path to Earth module

local shootRock = RS.RemoteEvents.ShootRock

--Example
local function handlePlayerEvent(player, mousePosition)
    local rock = Earth.new(player, 10, "Rock", "Attack")
    rock:Init()
    rock:Bend(mousePosition)
end

shootRock.OnServerEvent:Connect(handlePlayerEvent)