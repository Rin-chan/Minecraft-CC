-- Play sound using speakers

local speakers = peripheral.wrap("left")
speakers.playNote("harp", 1, 6)
sleep(1)
speakers.playSound("entity.sheep.hurt")