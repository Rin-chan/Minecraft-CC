-- Recreation of Flappy Bird game
-- Pastebin: https://pastebin.com/eWGqQxW4 (INCOMPLETE, 3/1/2023)

-- Meta class
Bird = {x = 0, y = 0}

-- Derived class method new
function Bird:new (o, x, y)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = x or 0
    self.y = y or 0
    return o
end

-- Action
function jump(bird)
    bird.y = bird.y - 3

    if bird.y < 1 then
        bird.y = 1
    end

    return bird
end

function fall(bird, maxHeight)
    bird.y = bird.y + 1

    if bird.y > maxHeight then
        bird.y = maxHeight
    end

    return bird
end

-- Run in parallel
local function tick()
    while true do
        term.setBackgroundColor(colors.black)
        term.clear()

        local stringScore = tostring(score)
        term.setCursorPos(width-string.len(stringScore), 1)
        term.write(score)

        term.setCursorPos(bird.x, bird.y)
        term.write("B")

        bird = fall(bird, height)
        sleep(0.5)
    end
end

local function wait_for_event()
    local eventData = nil
    local event = nil

    repeat
        ---@diagnostic disable-next-line: undefined-field
        eventData = {os.pullEvent()}
        event = eventData[1]
    until (event == "mouse_click" or event == "key")
    
    if event == "mouse_click" then
        bird = jump(bird)
    elseif event == "key" then
        if keys.getName(eventData[2]) == "q" then
            gameEnd = true
        end
    end
end

-- Main
score = 0
gameEnd = false
width, height = term.getSize()
bird = Bird:new({}, (width/2)-3, height/2)

while true do
    parallel.waitForAny(tick, wait_for_event)

    if gameEnd then
        break
    end
end