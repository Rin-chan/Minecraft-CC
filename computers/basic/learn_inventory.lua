-- NOT TESTED IN GAME YET

-- Display items in chest in the computer and monitor.

-- Main
chest = peripheral.find("minecraft:chest")
monitor = peripheral.find("monitor")

while true do
    for slot, item in pairs(chest.list()) do
        print(("%d x %s in slot %d"):format(item.count, item.name, slot))
        monitor.write(("%d x %s in slot %d"):format(item.count, item.name, slot))
    end
end