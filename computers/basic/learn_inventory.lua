-- Display items in chest in the computer and monitor. (Tested on 4x4 monitors)

-- Main
chest = peripheral.find("minecraft:chest")
monitor = peripheral.find("monitor")
 
monitor.setTextScale(1)
 
while true do
    monitor.clear()
 
    for slot, item in pairs(chest.list()) do
        print(("%d x %s in slot %d"):format(item.count, item.name, slot))
        monitor.setCursorPos(1,slot)
        monitor.write(("%d x %s in slot %d"):format(item.count, item.name, slot))
    end
    sleep(5)
end