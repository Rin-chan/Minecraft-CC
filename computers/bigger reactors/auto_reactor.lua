-- Run a reactor automatically (enable and disable automatically based on internal power storage)
-- Pastebin: https://pastebin.com/pkMuYheM (Updated on 10/4/2023)

local reactor = peripheral.wrap("back")
local pause = true
local lowThres = 0
local highThres = 100

local function button(x1, y1, x2, y2, text)
    term.setCursorPos(x1, y1)
    term.write(text)

    return {x1, y1, x2, y2}
end

local function notLessThan0(number)
    if number < 0 then
        number = 0
    end

    return number
end

local function notMoreThan100(number)
    if number > 100 then
        number = 100
    end

    return number
end

decreaseLowThres = button(41, 10, 42, 10, "<")
increaseLowThres = button(46, 10, 47, 10, ">")
decreaseHighThres = button(41, 13, 42, 13, "<")
increaseHighThres = button(46, 13, 47, 13, ">")
pauseButton = button(41, 5, 47, 5, "Enable")

local function work()
    term.clear()
    term.setCursorPos(2, 2)
    print(("Current energy level: %s"):format(reactor.battery().stored()))

    term.setCursorPos(2, 10)
    print(("Low Threshold: %s"):format(lowThres))

    term.setCursorPos(2, 13)
    print(("High Threshold: %s"):format(highThres))

    decreaseLowThres = button(41, 10, 42, 10, "<")
    increaseLowThres = button(46, 10, 47, 10, ">")
    decreaseHighThres = button(41, 13, 42, 13, "<")
    increaseHighThres = button(46, 13, 47, 13, ">")

    term.setCursorPos(2, 5)
    if pause then
        print("Current Status: Paused")
        pauseButton = button(41, 5, 47, 5, "Enable")
        reactor.setActive(false)
    else
        print("Current Status: Active")
        pauseButton = button(41, 5, 48, 5, "Disable")
    end

    if ((reactor.active() == false) and (pause == false)) then
        if (((reactor.battery().stored()/reactor.battery().capacity())*100) <= lowThres) then
            reactor.setActive(true)
        end
    else
        if (((reactor.battery().stored()/reactor.battery().capacity())*100) >= highThres) then
            reactor.setActive(false)
        end
    end

    sleep(0.1)
end

local function wait_for_event()
    ---@diagnostic disable-next-line: undefined-field
    local event, m_button, x, y = os.pullEvent("mouse_click")
    if m_button == 1 then
        if (x>=pauseButton[1] and x<=pauseButton[3]) then
            if (y>=pauseButton[2] and y<=pauseButton[4]) then
                if pause then
                    pause = false
                else
                    pause = true
                end
            end
        end

        if (y>=decreaseLowThres[2] and y<=decreaseLowThres[4]) then
            if (x>=decreaseLowThres[1] and x<=decreaseLowThres[3]) then
                lowThres = notLessThan0(lowThres - 1)
            elseif (x>=increaseLowThres[1] and x<=increaseLowThres[3]) then
                lowThres = notMoreThan100(lowThres + 1)
            end
        end

        if (y>=decreaseHighThres[2] and y<=decreaseHighThres[4]) then
            if (x>=decreaseHighThres[1] and x<=decreaseHighThres[3]) then
                highThres = notLessThan0(highThres - 1)
            elseif (x>=increaseHighThres[1] and x<=increaseHighThres[3]) then
                highThres = notMoreThan100(highThres + 1)
            end
        end
    end
end

while true do
    parallel.waitForAny(work, wait_for_event)
end