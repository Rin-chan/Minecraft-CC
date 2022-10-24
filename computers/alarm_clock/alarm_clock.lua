-- Alarm clock
-- Pastebin: https://pastebin.com/QUYTwstC (Updated on 24/10/2022)

local timezoneList = {}

function getTime(timezone)
    local url = "https://timeapi.io/api/Time/current/zone?timeZone=" ..timezone

    if http.get(url) ~= nil then
        request = http.get(url).readAll()
        return textutils.unserialiseJSON(request)
    else
        print("This url cannot be found.")
        return nil
    end
end

function getAlarm()
    local alarmFile = fs.open("alarm.txt", "r")
    local alarms = alarmFile.readAll()
    alarmFile.close()

    local alarmArray = {}
    for str in string.gmatch(alarms, "[^|]+") do
        str = string.gsub(str, "\n", "")
        for k, v in string.gmatch(str, "(.+)=(.+)") do
            alarmArray[k] = v
        end
    end

    return alarmArray
end

-- Main
print("What is your timezone? (eg. Asia/Singapore)")
local timezone = io.read()
local monitor = peripheral.wrap("right")
local speakers = peripheral.wrap("left")

while true do
    local timeJSON = getTime(timezone)

    monitor.clear()
    
    if timeJSON ~= nil then
        monitor.setCursorPos(1, 1)
        monitor.write(timeJSON.time)

        local alarms = getAlarm()

        local cursorHeight = 2
        for k, v in pairs(alarms) do
            monitor.setCursorPos(1, cursorHeight)

            if (v == timeJSON.time) then
                monitor.write(k.." at "..v.. " is ringing")
                speakers.playSound("entity.sheep.hurt")
            else
                monitor.write(k.." at "..v)
            end

            cursorHeight = cursorHeight + 1
        end
    else
        monitor.write("Something went wrong")
    end

    sleep(1)
end