-- Check what IV the Pokemon have
-- Not really exact sometimes at lower levels
-- Pastebin: https://pastebin.com/2jT5jXPZ (Updated on 31/8/2022)

-- Formula
-- HP = floor(0.01 x (2 x Base + IV + floor(0.25 x EV)) x Level) + Level + 10
-- Other Stats = (floor(0.01 x (2 x Base + IV + floor(0.25 x EV)) x Level) + 5) x Nature

local stats = {"HP", "Attack", "Defense", "Special Attack", "Special Defense", "Speed"}
local natureList = {"adamant", "bashful", "bold", "brave", "calm", "careful", "docile", "gentle", "hardy", "hasty", "impish", "jolly", "lax", "lonely", "mild", "modest", "naive", "naughty", "quiet", "quirky", "rash", "relaxed", "sassy", "serious", "timid"}

function getDataFromURL(url)
    if http.checkURL(url) then
        request = http.get(url).readAll()
        return request
    else
        print("This url cannot be found.")
    end
end

function statValid(stat, status)
    while true do
        print("What is the " ..status.. " " ..stat.. " stat of the Pokemon?")
        cur_val = io.read()

        if not tonumber(cur_val) then
            print("Enter a number.")
        else
            cur_val = tonumber(cur_val)
            break
        end
    end
    print("")

    return cur_val
end

function IVCheck(stat, IV)
    if IV < 0 then
        print(stat, 0)
    elseif IV > 31 then
        print(stat, 31)
    else
        print(stat, IV)
    end
end


-- Main
while true do
    print("")
    print("What would you like to do?")
    print("--------------------")
    print("(1) Check Pokemon IV stats (Note: You need to know the EVs stat of the Pokemon if the Pokemon has battled before.)")
    print("(2) Quit the program")
    print("--------------------")
    local choice = io.read()

    print("")
    if (choice == "1") then
        print("Which Pokemon would you like to check?")
        local pokemon = string.lower(io.read())

        local status, info = pcall(getDataFromURL, "https://pokeapi.co/api/v2/pokemon/" ..pokemon.. "/")

        print("")
        if status then
            local infoJSON = textutils.unserialiseJSON(info)

            while true do
                print("What is the Pokemon's current level?")
                level = io.read()

                if not tonumber(level) then
                    print("Enter a number.")
                else
                    level = tonumber(level)

                    if level < 0 then
                        print("Enter a number more than or equal to 0.")
                    elseif level > 100 then
                        print("Enter a number less than or equal to 100.")
                    else
                        break
                    end
                end
            end
            print("")

            local found = false
            repeat
                print("What is the Pokemon's nature?")
                nature = string.lower(io.read())
                print("")

                for i=1, 25 do
                    if (nature == natureList[i]) then
                        found = true
                        break
                    end
                end
            until found == true

            local cur_hp = statValid("HP", "current")
            local cur_atk = statValid("Attack", "current")
            local cur_def = statValid("Defense", "current")
            local cur_spatk = statValid("Special Attack", "current")
            local cur_spdef = statValid("Special Defense", "current")
            local cur_spd = statValid("Speed", "current")
        
            local infoAPI = getDataFromURL("https://pokeapi.co/api/v2/nature/" ..nature.. "/")
            local infoAPIJSON = textutils.unserialiseJSON(infoAPI)
            local nature_atk = 1
            local nature_def = 1
            local nature_spatk = 1
            local nature_spdef = 1
            local nature_spd = 1

            if (infoAPIJSON.increased_stat ~= nil) then
                if (infoAPIJSON.increased_stat.name == "attack") then
                    nature_atk = 1.1
                elseif (infoAPIJSON.increased_stat.name == "defense") then
                    nature_def = 1.1
                elseif (infoAPIJSON.increased_stat.name == "special-attack") then
                    nature_spatk = 1.1
                elseif (infoAPIJSON.increased_stat.name == "special-defense") then
                    nature_spdef = 1.1
                elseif (infoAPIJSON.increased_stat.name == "speed") then
                    nature_spd = 1.1
                end

                if (infoAPIJSON.decreased_stat.name == "attack") then
                    nature_atk = 0.9
                elseif (infoAPIJSON.decreased_stat.name == "defense") then
                    nature_def = 0.9
                elseif (infoAPIJSON.decreased_stat.name == "special-attack") then
                    nature_spatk = 0.9
                elseif (infoAPIJSON.decreased_stat.name == "special-defense") then
                    nature_spdef = 0.9
                elseif (infoAPIJSON.decreased_stat.name == "speed") then
                    nature_spd = 0.9
                end
            end

            while true do
                print("Has this Pokemon participated in battles before? (y/n)")
                local battledBefore = string.lower(io.read())
                print("")

                if (battledBefore == "y") then
                    local ev_hp = statValid("HP", "EV")
                    local ev_atk = statValid("Attack", "EV")
                    local ev_def = statValid("Defense", "EV")
                    local ev_spatk = statValid("Special Attack", "EV")
                    local ev_spdef = statValid("Special Defense", "EV")
                    local ev_spd = statValid("Speed", "EV")
                    
                    for k, v in pairs(infoJSON.stats) do
                        if (k == 1) then
                            local IV = math.floor(((cur_hp-10-level)/(0.01*level)) - 2*tonumber(v.base_stat) - 0.25*ev_hp + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 2) then
                            local IV = math.floor(((cur_atk/nature_atk) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) - 0.25*ev_atk + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 3) then
                            local IV = math.floor(((cur_def/nature_def) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) - 0.25*ev_def + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 4) then
                            local IV = math.floor(((cur_spatk/nature_spatk) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) - 0.25*ev_spatk + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 5) then
                            local IV = math.floor(((cur_spdef/nature_spdef) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) - 0.25*ev_spdef + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 6) then
                            local IV = math.floor(((cur_spd/nature_spd) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) - 0.25*ev_spd + 0.5)
                            IVCheck(stats[k], IV)
                        end
                    end

                    break
                elseif (battledBefore == "n") then
                    for k, v in pairs(infoJSON.stats) do
                        if (k == 1) then
                            local IV = math.floor(((cur_hp-10-level)/(0.01*level)) - 2*tonumber(v.base_stat) + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 2) then
                            local IV = math.floor(((cur_atk/nature_atk) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 3) then
                            local IV = math.floor(((cur_def/nature_def) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 4) then
                            local IV = math.floor(((cur_spatk/nature_spatk) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 5) then
                            local IV = math.floor(((cur_spdef/nature_spdef) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) + 0.5)
                            IVCheck(stats[k], IV)
                        elseif (k == 6) then
                            local IV = math.floor(((cur_spd/nature_spd) - 5)/(0.01 * level) - 2*tonumber(v.base_stat) + 0.5)
                            IVCheck(stats[k], IV)
                        end
                    end

                    break
                else
                    print("Not a valid choice.")
                end
            end
        else
            print("This Pokemon does not exist.")
        end
    elseif (choice == "2") then
        print("The program will quit.")
        break
    else
        print("Please enter 1 or 2.")
    end
end