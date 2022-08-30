-- Check what EV the Pokemon drops
-- Pastebin: https://pastebin.com/11wYfjE7

local stats = {"HP", "Attack", "Defense", "SpecialAttack", "SpecialDefense", "Speed"}

-- Main
url = "https://raw.githubusercontent.com/Rin-chan/Minecraft-CC/master/pixelmon/webScraping/EV_Scraping/EV_Data.csv"
if http.checkURL(url) then
    request = http.get(url).readAll()
    writeIn = fs.open("EV_Data", "w")
    writeIn.write(request)
    writeIn.close()
else
    print("This url cannot be found.")
end

while true do
    print("")
    print("What would you like to do?")
    print("--------------------")
    print("(1) Check Pokemon EV drops")
    print("(2) Quit the program")
    print("--------------------")
    local choice = io.read()

    print("")
    if (choice == "1") then
        print("Which Pokemon would you like to check?")
        local pokemon = string.lower(io.read())
        pokemon = pokemon:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)

        local found = false

        for line in io.lines("EV_Data") do
            local info = {}
            local count = 1

            for word in string.gmatch(line, '([^,]+)') do
                info[count] = word
                count = count + 1
            end

            if ("Pokémon" ~= info[1]) then
                if (pokemon == info[1]) then
                    print("")
                    for i=2, 7, 1 do
                        if (info[i] ~= "0") then
                            print(stats[i-1].. ": " ..info[i])
                        end
                    end

                    found = true
                end
            end
        end

        if found == false then
            print("This Pokemon does not exist.")
        end
    elseif (choice == "2") then
        print("The program will quit.")
        break
    else
        print("Please enter 1 or 2.")
    end
end