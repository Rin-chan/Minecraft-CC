-- Check what does each nature do
-- Pastebin: https://pastebin.com/RYXKWXj5 (Updated on 31/8/2022)

local natureList = {"adamant", "bashful", "bold", "brave", "calm", "careful", "docile", "gentle", "hardy", "hasty", "impish", "jolly", "lax", "lonely", "mild", "modest", "naive", "naughty", "quiet", "quirky", "rash", "relaxed", "sassy", "serious", "timid"}

function getDataFromURL(url)
    if http.checkURL(url) then
        request = http.get(url).readAll()
        return request
    else
        print("This url cannot be found.")
    end
end

-- Main
while true do
    print("")
    print("What would you like to do?")
    print("--------------------")
    print("(1) Check specific nature stats")
    print("(2) Show all natures and their stats")
    print("(3) Quit the program")
    print("--------------------")
    local choice = io.read()

    print("")
    if (choice == "1") then
        print("Which nature would you like to check?")
        local nature = string.lower(io.read())
        local found = false

        for i=1, 25 do
            if (nature == natureList[i]) then
                found = true
                break
            end
        end

        print("")
        if (found) then
            local info = getDataFromURL("https://pokeapi.co/api/v2/nature/" ..nature.. "/")
            local infoJSON = textutils.unserialiseJSON(info)

            if (infoJSON.increased_stat == nil) then
                print("Increased Stat: none")
                print("Decreased Stat: none")
            else
                print("Increased Stat: " ..infoJSON.increased_stat.name)
                print("Decreased Stat: " ..infoJSON.decreased_stat.name)
            end
        else
            print("This nature does not exist")
        end
    elseif (choice == "2") then
        for i=1, 25 do
            local info = getDataFromURL("https://pokeapi.co/api/v2/nature/" ..natureList[i].. "/")
            local infoJSON = textutils.unserialiseJSON(info)

            if (infoJSON.increased_stat == nil) then
                print("Nature: " ..infoJSON.name.. ", Increased Stat: none, Decreased Stat: none")
            else
                print("Nature: " ..infoJSON.name.. ", Increased Stat: " ..infoJSON.increased_stat.name.. ", Decreased Stat: " ..infoJSON.decreased_stat.name)
            end

            sleep(0.2)
        end
    elseif (choice == "3") then
        print("The program will quit.")
        break
    else
        print("Please enter 1, 2 or 3.")
    end
end