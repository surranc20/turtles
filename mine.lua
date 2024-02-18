function mine_line(line_len)
    while line_len > 1 do
        turtle.dig()
        turtle.forward()
        line_len = line_len - 1
    end
end

function travel_line(line_len)
    while line_len > 1 do
        turtle.forward()
        line_len = line_len - 1
    end
end

function dig_square(side_len)
    lines_to_dig = side_len
    on_starting_side = true

    while true do
        mine_line(side_len)
        lines_to_dig = lines_to_dig - 1
        on_starting_side = not on_starting_side

        if lines_to_dig == 0 then
            break
        end

        if on_starting_side then
            turtle.turnLeft()
            turtle.dig()
            turtle.forward()
            turtle.turnLeft()
        else
            turtle.turnRight()
            turtle.dig()
            turtle.forward()
            turtle.turnRight()
        end
    end

    if not on_starting_side then
        turtle.turnRight()
        turtle.turnRight()
        travel_line(side_len)
    end

    turtle.turnRight()
    travel_line(side_len)
    turtle.turnRight()
end

function dig_quary(side_len, depth, pre_drill)
    pre_drilled = 0
    while pre_drilled < pre_drill do
        turtle.digDown()
        turtle.down()
        pre_drilled = pre_drilled + 1
    end

    squares_to_dig = depth
    while squares_to_dig > 1 do
        dig_square(side_len)
        turtle.digDown()
        turtle.down()
        squares_to_dig = squares_to_dig - 1
    end

    depth = depth + pre_drill
    while depth > 0 do
        turtle.up()
        depth = depth - 1
    end
end

dig_quary(5, 40, 40)




