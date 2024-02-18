function mine_line(line_len)
    while line_len > 0 do
        turtle.dig()
        turtle.forward()er
        line_len = line_len - 1
    end

function travel_line(line_len)
    while line_len > 0 do
        turtle.forward()
        line_len = line_len - 1
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

    if not on_starting_side then
        turtle.turnRight()
        turtle.turnRight()
        travel_line(side_len)
    end

    turtle.turnRight()
    travel_line(side_len)
    turtle.turnRight()
end






