-- Recreation of Flappy Bird game
-- Pastebin:

-- Meta class
Bird = {x = 0, y = 0}

-- Derived class method new
function Bird:new (o,x,y)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = x or 0
    self.y = y or 0
    return o
end

-- Action
function jump(bird)
    bird.y = bird.y + 1
    return bird
end

-- Main
local score = 0

monitor = peripheral.wrap("right")
monitor.setBackgroundColor(colors.black)
monitor.clear()
local width, height = monitor.getSize()

while true do
    monitor.setCursorPos(width-tostring(score).len, 0)
    monitor.write(score)

    ---@diagnostic disable-next-line: undefined-field
    local event, m_button, x, y = os.pullEvent("monitor_touch")

    sleep(0.5)
end