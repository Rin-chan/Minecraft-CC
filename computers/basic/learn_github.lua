-- NOT TESTED IN GAME YET

-- Get codes from Github into the computer and save it for startup. (To replace Pastebin as it's easier to update on Github)

-- Main
url = "https://raw.githubusercontent.com/Rin-chan/Minecraft-CC/master/turtles/basic/learn_dig.lua"

if http.checkURL(url) then
    request = http.get(url).readAll()
    print(request)
    startup = fs.open("startup", "w")
    startup.write(request)
    startup.close()
    request.close()
else
    print("This url cannot be found.")
end