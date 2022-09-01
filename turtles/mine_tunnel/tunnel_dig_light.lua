-- Meant for digging tunnels using one mining turtle. (Runs on both normal and advanced mining turtles)
-- Turtle will according to the distance stated. A side tunnel is created every 3 blocks inbetween.
-- This would be more efficient if there was another turtle carrying torches as the turtle is forced to stop if it runs out of torches. The mining turtle would also contain chest so that it can store it's inventory as the turtle's inventory is very small.
-- Multi-turtle version in intermediate.
-- NOT TESTED ENOUGH FOR USAGE

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
    turtle.placeDown()
end

function dig_straight()
    -- Dig if there is a block in front
    if turtle.detect() then
        turtle.dig()
        sleep(0.5)
    end
end

function dig_down()
    -- Dig if there is a block on bottom
    if turtle.detectDown() then
        turtle.digDown()
        sleep(0.5)
    end
end

function tunnel_dig(tunnel)
    -- Dig a side tunnel
    for tunnel_count=1, tunnel, 1 do
        dig_straight()
        turtle.forward()
        dig_down()

        if tunnel_count%8 == 0 then
            placeTorches()
        end
    end

    -- Turn 180 degree
    turtle.turnLeft()
    turtle.turnLeft()

    -- Move back to starting position
    for tunnel_count=1, tunnel, 1 do
        turtle.forward()
    end
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

moved = 0
for count=1, distance, 1 do
    -- Main Tunnel
    if count%40 == 0 then
        refuel()
    end

    dig_straight()
    turtle.forward()
    dig_down()

    if count%8 == 0 then
        placeTorches()
    end

    -- Side Tunnels
    if (count%4 == 0) and (count ~= 1) then

        -- Dig right side 
        turtle.turnRight()
        tunnel_dig(tunnel)

        -- Dig Left side
        tunnel_dig(tunnel)

        -- Go back to center
        turtle.turnLeft()
    end

    moved = count

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
for backward=1, moved, 1 do
    turtle.forward()
end