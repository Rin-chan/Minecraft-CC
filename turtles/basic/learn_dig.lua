-- Meant for learning how to dig in a straight line using mining turtles. (Runs on both normal and advanced mining turtles)
-- Turtle will mine infinity (until it runs out of fuel)
-- This does not include refueling. Fuel will have to be added before running these codes.
-- NOT RECOMMENDED FOR USAGE

function dig()
    -- Turtle will not dig if there isn't a block in front
    while turtle.detect() do
        turtle.dig()
        sleep(0.5) -- Prevent the turtle from trying to move when Minecraft still detect a block in front of it
    end

    turtle.forward()
end

-- Main
while true do
    dig()
end
