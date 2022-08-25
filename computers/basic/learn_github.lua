-- Get codes from Github into the computer and save it for startup. (To replace Pastebin as it's easier to update on Github & learn http in CC)

-- Main
print("Enter Github Raw URL:")
url = io.read()

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