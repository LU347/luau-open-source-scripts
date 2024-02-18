---
title: Timer Module
---
## Description

The timer module provides functionality for creating and managing multiple timers. It can be used on the server or client scripts, depending on your needs.

## Construction / Initialization

<SwmSnippet path="Timer-Module/server/Timer.lua" line="5">

---

Creates a new timer object with the given properties: name (string), duration (int), isRunning (boolean), startTime (int), currentTime (int). The timer is then inserted into Timer.timerList table to keep track of the object.

```lua
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
```

---

</SwmSnippet>

## Functions

### <SwmToken path="/Timer-Module/server/Timer.lua" pos="19:2:6" line-data="function Timer:Start()">`Timer:Start()`</SwmToken>

<SwmSnippet path="Timer-Module/server/Timer.lua" line="19">

---

Starts the timer and utilizes RunService's Heartbeat function to update the timer.

```lua
function Timer:Start()
    if (not self.isRunning) then
        self.isRunning = true
        self.startTime = tick()
        self._connection = RunService.Heartbeat:Connect(function()
            self:Update()
        end)
    end
end
```

---

</SwmSnippet>

### <SwmToken path="/Timer-Module/server/Timer.lua" pos="29:2:6" line-data="function Timer:Update()">`Timer:Update()`</SwmToken>

<SwmSnippet path="/Timer-Module/server/Timer.lua" line="29">

---

Calculates the elapsed time and updates the current time in the format mm:ss.

```lua
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
```

---

</SwmSnippet>

### <SwmToken path="/Timer-Module/server/Timer.lua" pos="47:2:6" line-data="function Timer:Stop()">`Timer:Stop()`</SwmToken>

<SwmSnippet path="/Timer-Module/server/Timer.lua" line="47">

---

Resets the timer's duration and stops it from running.

```lua
function Timer:Stop()
    self.duration = 0
    self.isRunning = false
end
```

---

</SwmSnippet>

### <SwmToken path="/Timer-Module/server/Timer.lua" pos="52:2:6" line-data="function Timer:Destroy()">`Timer:Destroy()`</SwmToken>

<SwmSnippet path="/Timer-Module/server/Timer.lua" line="52">

---

This function removes the timer from Timer.timerList, disconnects the connection and clears the object table.

```lua
function Timer:Destroy()
    table.remove(Timer.timerList, table.find(Timer.timerList, self))
    self._connection:Disconnect()
    self = {}
end
```

---

</SwmSnippet>

<SwmMeta version="3.0.0" repo-id="Z2l0aHViJTNBJTNBbHVhdS1vcGVuLXNvdXJjZS1zY3JpcHRzJTNBJTNBTFUzNDc=" repo-name="luau-open-source-scripts"><sup>Powered by [Swimm](https://app.swimm.io/)</sup></SwmMeta>
