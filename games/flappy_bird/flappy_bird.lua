-- Recreation of Flappy Bird game
-- Pastebin: https://pastebin.com/eWGqQxW4 (Updated on 3/1/2023)

-- Bird class
Bird = {x=0, y=0}

-- Bird class method new
function Bird:new (o, x, y)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.x = x or 0
    self.y = y or 0
    return o
end

-- Bird Action
function jump(bird)
    bird.y = bird.y - 3

    if bird.y < 2 then
        bird.y = 2
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

-- Board class
Board = {obs={}}

-- Board class method new
function Board:new (o, obs)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.obs = obs or {}
    return o
end

-- Board Action
function moveBoard(board, maxWidth, maxHeight)
    local temArray = {}
    local lastK = 1
    local lastX = 0

    -- Move current obstacles
    for k, v in pairs(board.obs) do
        if (k == nil or v[1] == nil or v[2] == nil or v[3] == nil) then
            break
        end

        temArray[k]={(v[1]-1), v[2], v[3]}
        lastX = v[1]-1
        lastK = k+1
    end

    -- Add new obstacles
    if maxWidth-lastX > 12 then
        topHeight = math.random(2, maxHeight-5)
        bottomHeight = math.random(topHeight+5, maxHeight)
        temArray[lastK]={maxWidth, topHeight, bottomHeight}
    end

    board.obs = temArray
    return board
end

-- Run in parallel
local function tick()
    term.setBackgroundColor(colors.black)
    term.clear()

    local stringScore = tostring(score)
    term.setCursorPos(width-string.len(stringScore), 1)
    term.write(score)

    term.setCursorPos(bird.x, bird.y)
    term.write("B")

    for k, v in pairs(board.obs) do
        if (k == nil or v[1] == nil or v[2] == nil or v[3] == nil) then
            break
        end

        if v[2] ~= 2 then
            for i=2, v[2], 1
            do
                term.setCursorPos(v[1], i)
                term.write("P")

                -- Check for collision
                if (bird.x+1 == v[1] and bird.y == i) then
                    gameEnd = true
                end

                if (bird.x == v[1] and bird.y-1 == i) then
                    gameEnd = true
                end
            end
        end

        if v[3] ~= height then
            for i=v[3], height, 1
            do
                term.setCursorPos(v[1], i)
                term.write("P")

                -- Check for collision
                if (bird.x+1 == v[1] and bird.y == i) then
                    gameEnd = true
                end

                if (bird.x == v[1] and bird.y-1 == i) then
                    gameEnd = true
                end
            end
        end
    end

    bird = fall(bird, height)
    board = moveBoard(board, width, height)
    sleep(0.3)
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
bird = Bird:new({}, math.floor((width/2)-3+0.5), math.floor((height/2)+0.5))
board = Board:new({}, {})

-- Randomize map
math.randomseed(os.time())
math.random()
math.random()
math.random()

while true do
    parallel.waitForAny(tick, wait_for_event)

    if gameEnd then
        term.setBackgroundColor(colors.black)
        term.clear()

        local stringScore = tostring(score)
        term.setCursorPos(width-string.len(stringScore), 1)
        term.write(score)

        term.setCursorPos(width/2-4, height/2)
        term.setTextColor(colors.red)
        term.write("Game Over")
        break
    else
        score = score + 1
    end
end