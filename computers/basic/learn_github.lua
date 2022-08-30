-- Get codes from Github into the computer and save it for startup. (To replace Pastebin as it's easier to update on Github & learn http in CC)
-- Pastebin: https://pastebin.com/q40wsKBB (Updated on 31/8/2022)

-- Main
print("Enter Github Raw URL:")
url = io.read()

if http.checkURL(url) then
    request = http.get(url).readAll()
    
    print("Where do you want to save this file?")
    location = io.read()

    writeIn = fs.open(location, "w")
    writeIn.write(request)
    writeIn.close()
else
    print("This url cannot be found.")
end