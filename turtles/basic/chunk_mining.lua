-- Meant for clearing one chunk using one mining turtle. (Runs on both normal and advanced mining turtles)
-- Turtle will mine a 16x16 Minecraft chunk, starting from the bottom left corner of the chunk.
-- Recommend to feed blocks of coal/charcoal so that the turtle will not run out of fuel while digging through one chunk
-- Place a chest on top of the starting position of the turtle to collect items
-- Turtle should equip shovel and pickaxe to prevent inability to dig through dirts

refuelLevel = 300
chunk = 16

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

function dig()
    -- Dig the block below it
    if turtle.detectDown() then
        turtle.digDown()
        sleep(0.5)
    end
end

function row()
    -- Dig one row
    for count=1, chunk, 1 do
        dig()

        if (count ~= chunk) then
            turtle.forward()
        end
    end
end

function layer()
    -- Dig one layer
    for count=1, chunk, 1 do
        row()

        if (count ~= chunk) then
            if (count%2 == 0) then
                turtle.turnLeft()
                turtle.forward()
                turtle.turnLeft()
            else
                turtle.turnRight()
                turtle.forward()
                turtle.turnRight()
            end
        end
    end

    -- Return to start
    turtle.turnRight()
    for count=1, chunk-1, 1 do
        turtle.forward()
    end
end

-- Main
print("Start the program? (y/n)")
start = io.read()

if (start == "y") then
    print("How far down?")
    distance = tonumber(io.read())

    -- Mine according to the distance given
    for i=1, distance, 1 do
        refuel()
        layer()

        -- Move back to the chest
        for up=1, i, 1 do
            if (up ~= i) then
                turtle.up()
            end
        end

        -- Put everything in the turtle inventory into the chest
        for inv=2, 16, 1 do
            turtle.select(inv)
            turtle.dropUp()
        end

        if (i == distance) then
            break
        end

        turtle.turnRight()

        -- Move back to previous position
        for down=1, i+1, 1 do
            if (down ~= i) then
                turtle.down()
            end
        end
    end
end