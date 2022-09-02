-- Pocket Calculator (Only been tested on pocket computers)
-- Pastebin: https://pastebin.com/HxWw6Fkp (Updated on 3/9/2022)

function addition(a, b)
    local result = a + b
    return result
end

function subtraction(a, b)
    local result = a - b
    return result
end

function multiplication(a, b)
    local result = a * b
    return result
end

function division(a, b)
    local result = a / b
    return result
end

function signIdentify(sign, a, b)
    local result = 0

    if sign == "+" then
        result = addition(a, b)
    elseif sign == "-" then
        result = subtraction(a, b)
    elseif sign == "x" then
        result = multiplication(a, b)
    elseif sign == "÷" then
        result = division(a, b)
    end

    return result
end

function button(x1, y1, x2, y2, color, text, x_alignment, y_alignment, text_color)
    term.setBackgroundColor(color)
    term.setTextColor(text_color)
    for y=y1, y2 do
        for x=x1, x2 do
            term.setCursorPos(x, y)
            term.write(" ")
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

    term.setCursorPos(textLoc_x, textLoc_y)
    term.write(text)

    return {x1, y1, x2, y2}
end

-- Main
---@diagnostic disable-next-line: undefined-field
os.setComputerLabel("Calculator")
term.setBackgroundColor(colors.black)
term.clear()

-- Result screen
local previousArea = button(1, 1, 26, 3, colors.black, "", "right", "bottom", colors.gray)
local resultArea = button(1, 4, 26, 4, colors.black, "0", "right", "bottom", colors.white)
local spacingArea = button(1, 5, 26, 5, colors.black, "", "right", "bottom", colors.white)

-- Function buttons
local plusButton = button(19, 15, 26, 17, colors.gray, "+", "center", "center", colors.white)
local minusButton = button(19, 12, 26, 14, colors.gray, "-", "center", "center", colors.white)
local multiButton = button(19, 9, 26, 11, colors.gray, "x", "center", "center", colors.white)
local diviButton = button(13, 6, 18, 8, colors.gray, "÷", "center", "center", colors.white)
local equalButton = button(19, 18, 26, 20, colors.gray, "=", "center", "center", colors.white)
local clearButton = button(7, 6, 12, 8, colors.gray, "C", "center", "center", colors.white)
local clearAllButton = button(1, 6, 6, 8, colors.gray, "CE", "center", "center", colors.white)
local backButton = button(19, 6, 26, 8, colors.gray, "<-", "center", "center", colors.white)
local dotButton = button(13, 18, 18, 20, colors.black, ".", "center", "center", colors.white)

-- Number buttons
local zeroButton = button(1, 18, 12, 20, colors.black, "0", "center", "center", colors.white)
local oneButton = button(1, 15, 6, 17, colors.black, "1", "center", "center", colors.white)
local twoButton = button(7, 15, 12, 17, colors.black, "2", "center", "center", colors.white)
local threeButton = button(13, 15, 18, 17, colors.black, "3", "center", "center", colors.white)
local fourButton = button(1, 12, 6, 14, colors.black, "4", "center", "center", colors.white)
local fiveButton = button(7, 12, 12, 14, colors.black, "5", "center", "center", colors.white)
local sixButton = button(13, 12, 18, 14, colors.black, "6", "center", "center", colors.white)
local sevenButton = button(1, 9, 6, 11, colors.black, "7", "center", "center", colors.white)
local eightButton = button(7, 9, 12, 11, colors.black, "8", "center", "center", colors.white)
local nineButton = button(13, 9, 18, 11, colors.black, "9", "center", "center", colors.white)

-- Save input
local result = ""
local previous_number = ""
local current_number = "0"

while true do
    ---@diagnostic disable-next-line: undefined-field
    local m_event, m_button, x, y = os.pullEvent("mouse_up")

    if m_button == 1 then
        -- Prevent user from entering too many numbers
        if string.len(current_number) <= 20 then
            if (x>=zeroButton[1] and x<=zeroButton[3]) then
                if (y>=zeroButton[2] and y<=zeroButton[4]) then
                    if current_number == "0" then
                        current_number = "0"
                    else
                        current_number = current_number.."0"
                    end
                end
            end

            if (x>=oneButton[1] and x<=oneButton[3]) then
                if (y>=oneButton[2] and y<=oneButton[4]) then
                    if current_number == "0" then
                        current_number = "1"
                    else
                        current_number = current_number.."1"
                    end
                end
            end

            if (x>=twoButton[1] and x<=twoButton[3]) then
                if (y>=twoButton[2] and y<=twoButton[4]) then
                    if current_number == "0" then
                        current_number = "2"
                    else
                        current_number = current_number.."2"
                    end
                end
            end

            if (x>=threeButton[1] and x<=threeButton[3]) then
                if (y>=threeButton[2] and y<=threeButton[4]) then
                    if current_number == "0" then
                        current_number = "3"
                    else
                        current_number = current_number.."3"
                    end
                end
            end

            if (x>=fourButton[1] and x<=fourButton[3]) then
                if (y>=fourButton[2] and y<=fourButton[4]) then
                    if current_number == "0" then
                        current_number = "4"
                    else
                        current_number = current_number.."4"
                    end
                end
            end

            if (x>=fiveButton[1] and x<=fiveButton[3]) then
                if (y>=fiveButton[2] and y<=fiveButton[4]) then
                    if current_number == "0" then
                        current_number = "5"
                    else
                        current_number = current_number.."5"
                    end
                end
            end

            if (x>=sixButton[1] and x<=sixButton[3]) then
                if (y>=sixButton[2] and y<=sixButton[4]) then
                    if current_number == "0" then
                        current_number = "6"
                    else
                        current_number = current_number.."6"
                    end
                end
            end

            if (x>=sevenButton[1] and x<=sevenButton[3]) then
                if (y>=sevenButton[2] and y<=sevenButton[4]) then
                    if current_number == "0" then
                        current_number = "7"
                    else
                        current_number = current_number.."7"
                    end
                end
            end

            if (x>=eightButton[1] and x<=eightButton[3]) then
                if (y>=eightButton[2] and y<=eightButton[4]) then
                    if current_number == "0" then
                        current_number = "8"
                    else
                        current_number = current_number.."8"
                    end
                end
            end

            if (x>=nineButton[1] and x<=nineButton[3]) then
                if (y>=nineButton[2] and y<=nineButton[4]) then
                    if current_number == "0" then
                        current_number = "9"
                    else
                        current_number = current_number.."9"
                    end
                end
            end

            if (x>=dotButton[1] and x<=dotButton[3]) then
                if (y>=dotButton[2] and y<=dotButton[4]) then
                    if current_number == "0" then
                        current_number = "."
                    else
                        local found = false
                        for i = 1, #current_number do
                            local c = current_number:sub(i,i)
                            if c == "." then
                                found = true
                            end
                        end

                        if not found then
                            current_number = current_number.."."
                        end
                    end
                end
            end
        end


        if (x>=backButton[1] and x<=backButton[3]) then
            if (y>=backButton[2] and y<=backButton[4]) then
                if current_number == "0" then
                    current_number = "0"
                else
                    current_number = string.sub(current_number, 1, string.len(current_number)-1)

                    if string.len(current_number) < 1 then
                        current_number = "0"
                    end
                end
            end
        end

        if (x>=clearButton[1] and x<=clearButton[3]) then
            if (y>=clearButton[2] and y<=clearButton[4]) then
                current_number = "0"
            end
        end

        if (x>=clearAllButton[1] and x<=clearAllButton[3]) then
            if (y>=clearAllButton[2] and y<=clearAllButton[4]) then
                current_number = "0"
                previous_number = ""
            end
        end


        if (x>=plusButton[1] and x<=plusButton[3]) then
            if (y>=plusButton[2] and y<=plusButton[4]) then
                if previous_number ~= "" then
                    local sign = string.sub(previous_number, string.len(previous_number), string.len(previous_number))
                    previous_number = tostring(signIdentify(sign, tonumber(string.sub(previous_number, 1, string.len(previous_number)-2)), tonumber(current_number))).." +"
                else
                    previous_number = current_number.." +"
                end

                current_number = "0"
            end
        end

        if (x>=minusButton[1] and x<=minusButton[3]) then
            if (y>=minusButton[2] and y<=minusButton[4]) then
                if previous_number ~= "" then
                    local sign = string.sub(previous_number, string.len(previous_number), string.len(previous_number))
                    previous_number = tostring(signIdentify(sign, tonumber(string.sub(previous_number, 1, string.len(previous_number)-2)), tonumber(current_number))).." -"
                else
                    previous_number = current_number.." -"
                end

                current_number = "0"
            end
        end

        if (x>=multiButton[1] and x<=multiButton[3]) then
            if (y>=multiButton[2] and y<=multiButton[4]) then
                if previous_number ~= "" then
                    local sign = string.sub(previous_number, string.len(previous_number), string.len(previous_number))
                    previous_number = tostring(signIdentify(sign, tonumber(string.sub(previous_number, 1, string.len(previous_number)-2)), tonumber(current_number))).." x"
                else
                    previous_number = current_number.." x"
                end

                current_number = "0"
            end
        end

        if (x>=diviButton[1] and x<=diviButton[3]) then
            if (y>=diviButton[2] and y<=diviButton[4]) then
                if previous_number ~= "" then
                    local sign = string.sub(previous_number, string.len(previous_number), string.len(previous_number))
                    previous_number = tostring(signIdentify(sign, tonumber(string.sub(previous_number, 1, string.len(previous_number)-2)), tonumber(current_number))).." ÷"
                else
                    previous_number = current_number.." ÷"
                end

                current_number = "0"
            end
        end

        if (x>=equalButton[1] and x<=equalButton[3]) then
            if (y>=equalButton[2] and y<=equalButton[4]) then
                if previous_number ~= "" then
                    local sign = string.sub(previous_number, string.len(previous_number), string.len(previous_number))
                    current_number = tostring(signIdentify(sign, tonumber(string.sub(previous_number, 1, string.len(previous_number)-2)), tonumber(current_number)))
                    previous_number = ""
                end
            end
        end
    end

    previousArea = button(1, 1, 26, 3, colors.black, previous_number, "right", "bottom", colors.gray)
    resultArea = button(1, 4, 26, 4, colors.black, current_number, "right", "bottom", colors.white)
end