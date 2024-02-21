--[[
    Module script that handles Earth-type moves
    It currently only has one move at the moment
    If I were to add multiple moves, there would be a separate module
    storing all the moves and its respective properties
]]--

local RS = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

Earth = {}
Earth.__index = Earth

local Z_OFFSET = -5
local THROW_SPEED = 100

function Earth.new(player, damage, modelName, bendType, staminaCost)
    local self = setmetatable({}, Earth)
    self.Damage = damage
    self.Owner = player
    self.Model = modelName
    self.Debounce = false
    self.Type = bendType

    return self
end

function Earth:Init()
    self.Model = RS:FindFirstChild(self.Model):Clone()
    self.touchConn = self.Model.Touched:Connect(function(hit)
        self:OnTouch(hit)
    end)
    self.Model.Destroying:Connect(function()
        self:Cleanup()
    end)
end

function Earth:OnTouch(hit)
    if self.Debounce then
        return
    end
    
    local humanoid = hit.Parent:FindFirstChild("Humanoid")
    if humanoid and humanoid.Parent.Name ~= self.Owner.Name then
        humanoid:TakeDamage(self.Damage)
    end
end

--[[
    Fires a spinning rock with the given mouse target position
    Walkspeed is set to 0 if you want to add an animation while bending
    Adjust the wait() interval depending on the animation length
]]--
function Earth:Bend(mousePosition)
    local rock = self.Model
    rock.Parent = workspace
	rock.CFrame = self.Owner.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,Z_OFFSET)
	
	local newForce = Instance.new("BodyForce")
	newForce.Force = Vector3.new(0, workspace.Gravity * rock:GetMass(), 0)
	newForce.Parent = rock
	
	rock.Velocity = CFrame.new(self.Owner.Character.HumanoidRootPart.Position, mousePosition).LookVector * THROW_SPEED
    
    self.Owner.Character.Humanoid.WalkSpeed = 0
    wait(.25)
    self.Owner.Character.Humanoid.WalkSpeed = 16
    
    Debris:AddItem(rock,2)
    
    local function spinRock()
        rock.CFrame = rock.CFrame * CFrame.Angles(0, 0, math.rad(10))
    end
    
    RunService.Heartbeat:Connect(spinRock)
end

function Earth:Cleanup()
    self.Model:Destroy()
    self.touchConn:disconnect()
    self = {}
end

return Earth