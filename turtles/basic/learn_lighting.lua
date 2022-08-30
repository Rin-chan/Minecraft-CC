-- Meant for learning how to set torches in a straight line using environment turtles. (Runs on both normal and advanced environment turtles)
-- This requires Advanced Peripherals, https://www.curseforge.com/minecraft/mc-mods/advanced-peripherals.
-- Turtle will add torches until it runs out or does not have a place to move. (It will continue to move even without torches)
-- This does not include refueling. Fuel will have to be added before running these codes.
-- NOT RECOMMENDED FOR USAGE

function torches()
    -- Turtle will add a torch above it (to prevent hostile mob spawns)
    -- This places a torch when the light level less than or equal to 4.
    if (detector.getBlockLightLevel() < 6) then
        turtle.placeUp()
        sleep(0.5)
    end

    turtle.forward()
end

-- Main
turtle.select(1) -- Get torches from the first slot of it's inventory
detector = peripheral.find("environmentDetector")

while true do
    torches()
end