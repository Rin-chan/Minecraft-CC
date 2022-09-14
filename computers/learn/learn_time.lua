-- Display time in computer (Will add monitor in the future)
-- Pastebin: https://pastebin.com/jbmzwMFP (Updated on 14/9/2022)

local timezoneList = {}

function getTime(timezone)
    url = "https://timeapi.io/api/Time/current/zone?timeZone=" ..timezone

    if http.get(url) ~= nil then
        request = http.get(url).readAll()
        return textutils.unserialiseJSON(request)
    else
        print("This url cannot be found.")
        return nil
    end
end

function conversion12Hour(time)
    local am_pm = "AM"
    local hour = string.sub(time, 1, 2)
    local minute = string.sub(time, 4, 5)

    if tonumber(string.sub(time, 1, 2)) > 12 then
        am_pm = "PM"
        hour = tostring(tonumber(string.sub(time, 1, 2)) - 12)
    end

    local result = hour.. ":" ..minute.. " " ..am_pm
    return result
end

print("What is your timezone? (eg. Asia/Singapore)")
local timezone = io.read()

local monitor = peripheral.find("monitor")

while true do
    local timeJSON = getTime(timezone)

    monitor.clear()
    monitor.setCursorPos(2, 2)
    
    if timeJSON ~= nil then
        monitor.write(conversion12Hour(timeJSON.time))
    else
        monitor.write("Something went wrong")
    end

    sleep(1)
end