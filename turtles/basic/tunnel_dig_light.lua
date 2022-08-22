-- NOT TESTED IN GAME YET

-- Meant for digging tunnels using one mining turtle. (Runs on both normal and advanced mining turtles)
-- Turtle will according to the distance stated. A side tunnel is created every 3 blocks inbetween.
-- This would be more efficient if there was another turtle carrying torches as the turtle is forced to stop if it runs out of torches. The mining turtle would also contain chest so that it can store it's inventory as the turtle's inventory is very small.
-- Multi-turtle version in intermediate.

refuelLevel = 160


function refuel()
    -- Get fuel in slot 1
    turtle.select(1)

    -- Check to make sure it is a fuel
    if turtle.refuel(0) then
        -- Only refuel if it is lower than a certain point
        if turtle.getFuelLevel() < refuelLevel then
            turtle.refuel(8)
        end
    else
        print("Turtle cannot refuel")
    end
end

function placeTorches()
    -- Get torches in slot 2
    turtle.select(2)
    turtle.placeUp()
end

function dig()
    -- Dig if there is a block in front
    if turtle.detect() then
        turtle.dig()
    end

    turtle.forward()

    -- Dig if there is a block on top
    if turtle.detectUp() then
        turtle.digUp()
    end
end

function tunnel(tunnel)
    -- Dig a side tunnel
    for tunnel_count=0, tunnel, 1 do
        dig()

        if tunnel_count%8 == 0 then
            placeTorches()
        end
    end

    -- Turn 180 degree
    turtle.turnLeft()
    turtle.turnLeft()

    -- Move back to starting position
    for tunnel_count=0, tunnel, 1 do
        turtle.forward()
    end

    turtle.forward()
end

function checkInventory()
    -- Stop mining when the turtle is about to run out of torches
    if turtle.getItemCount(2) < 8 then
        return true
    end

    -- Stop mining when the turtle's inventory is full
    if turtle.getItemCount(16) > 0 then
        return true
    end
end

-- Main
print("Put fuel in slot 1, torches in slot 2")
print("How far do you want to dig?")
distance = io.read()
print("How far each tunnel will go?")
tunnel = io.read()

for count=0, distance, 1 do
    -- Main Tunnel
    if count%40 == 0 then
        refuel()
    end

    dig()

    if count%8 == 0 then
        placeTorches()
    end

    -- Side Tunnels
    if (count%3 == 0) and (count ~= 0) then

        -- Dig right side 
        turtle.turnRight()
        tunnel(tunnel)

        -- Dig Left side
        tunnel(tunnel)

        -- Go back to center
        turtle.turnLeft()
    end

    -- Stop the turtle if fuel gets below a certain point
    if turtle.getItemCount(1) < 16 then
        break
    end

    -- Stop the turtle if running out of torches or full inventory
    if checkInventory() then
        break
    end
end

-- Turn backwards
turtle.turnLeft()
turtle.turnLeft()

-- Move back to starting location
for backward=0, count, 1 do
    turtle.forward()
end