-- Meant for learning how to dig in tunnel using mining turtles. (Runs on both normal and advanced mining turtles)
-- Turtle will according to the distance stated. A side tunnel is created every 3 blocks inbetween.

function refuel()
    turtle.select(1)

    if turtle.refuel(0) then
        turtle.refuel(2)
    else
        print("Turtle cannot refuel")
    end
end

function placeTorches()
    turtle.select(2)
    turtle.placeUp()
end

function dig()
    if turtle.detect() then
        turtle.dig()
    end

    if turtle.detectUp() then
        turtle.digUp()
    end

    turtle.forward()
end

function tunnel(tunnel)
    for tunnel_count=0, tunnel, 1 do
        dig()

        if tunnel_count%8 == 0 then
            placeTorches()
        end
    end

    turtle.turnLeft()
    turtle.turnLeft()

    for tunnel_count=0, tunnel, 1 do
        turtle.forward()
    end

    turtle.forward()
end

-- Main
print("Put fuel in slot 1, torches in slot 2")
print("How far do you want to dig?")
distance = io.read()
print("How far each tunnel will go?")
tunnel = io.read()

for count=0, distance, 1 do
    if count%100 == 0 then
        refuel()
    end

    dig()

    if count%8 == 0 then
        placeTorches()
    end

    if (count%3 == 0) and (count ~= 0) then
        turtle.turnRight()

        tunnel(tunnel)

        turtle.turnLeft()

    end
end
