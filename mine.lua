function mine_line(line_len)
    while line_len > 0 do
        turtle.dig()
        turtle.forward
        line_len -= 1
    end

-- fix to work with odds
function dig_square(side_len)
    lines_to_dig = side_len
    while lines_to_dig > 1 do
        mine_line(side_len)
        turtle.turnRight()
        turtle.dig()
        -- might need to go one less
        mine_line(side_len)
        lines_to_dig -= 1
    end
