local RunService = game:GetService("RunService")
local Timer = {}
Timer.__index = Timer

Timer.timerList = {}

function Timer.new(name, duration)
    local self = setmetatable({}, Timer)
    self.name = name
    self.duration = duration
    self.isRunning = false
    self.startTime = 0
    self.currentTime = 0
    table.insert(Timer.timerList, self)

    return self
end

function Timer:Start()
    if (not self.isRunning) then
        self.isRunning = true
        self.startTime = tick()
        self._connection = RunService.Heartbeat:Connect(function()
            self:Update()
        end)
    end
end

function Timer:Update()
    if (self.isRunning) then
        local elapsedTime = tick() - self.startTime
        local timeLeft = self.duration - elapsedTime
        local seconds = math.floor(timeLeft % 60)
        local minutes = math.floor(timeLeft/60)

        if (timeLeft <= 0) then
            self.isRunning = false
            self:Destroy()
        else
            self.currentTime = minutes .. ":" .. (10 > seconds and "0" .. seconds or seconds)
        end

        wait(1)
    end
end

function Timer:Stop()
    self.duration = 0
    self.isRunning = false
end

function Timer:Destroy()
    table.remove(Timer.timerList, table.find(Timer.timerList, self))
    self._connection:Disconnect()
    self = {}
end

return Timer