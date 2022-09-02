-- Create clickable buttons on screen (Tested on 2x2 advanced monitors)
-- Requires advanced monitors (for clickable buttons), coordinate of the button, color of the button, text in the button and the alignment of the text in the button.
-- Pastebin: https://pastebin.com/81WAuRjk (Updated on 2/9/2022)

function button(monitor, x1, y1, x2, y2, color, text, x_alignment, y_alignment)
    if string.len(text) > (x2-x1+1) then
        print("Button cannot be added as text is longer than the button.")
        return {}
    end

    monitor.setBackgroundColor(color)
    for y=y1, y2 do
        for x=x1, x2 do
            monitor.setCursorPos(x, y)
            monitor.write(" ")
        end
    end

    local textLoc_x = 1
    local textLoc_y = 1

    if x_alignment == "left" then
        textLoc_x = x1
    elseif x_alignment == "center" then
        local success = false
        local removeChar = 0

        repeat
            textLoc_x = math.floor((x1+x2)/2)-math.floor(string.len(text)/2)-removeChar

            if (textLoc_x+string.len(text)) > x2+1 then
                removeChar = removeChar + 1
            else
                success = true
            end
        until success == true
    elseif x_alignment == "right" then
        textLoc_x = x2-string.len(text)
    end

    if y_alignment == "top" then
        textLoc_y = y1
    elseif y_alignment == "center" then
        textLoc_y = math.floor((y1+y2)/2)
    elseif y_alignment == "bottom" then
        textLoc_y = y2
    end

    monitor.setCursorPos(textLoc_x, textLoc_y)
    monitor.write(text)

    return {x1, y1, x2, y2}
end

-- Main
monitor = peripheral.wrap("right")
monitor.setBackgroundColor(colors.black)
monitor.clear()
local button1 = button(monitor, 2, 2, 8, 4, colors.blue, "Hello", "center", "center")

while true do
---@diagnostic disable-next-line: undefined-field
    local event, m_button, x, y = os.pullEvent("monitor_touch")

    print(("The mouse button %s was pressed at %d, %d"):format(m_button, x, y))
    if m_button == "right" then
        if (x>=button1[1] and x<=button1[3]) then
            if (y>=button1[2] and y<=button1[4]) then
                print("Clicked")
            end
        end
    end
end