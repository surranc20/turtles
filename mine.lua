local function mine_line(line_len)
    while line_len > 1 do
        turtle.dig()
        turtle.forward()
        line_len = line_len - 1
    end
end

local function travel_line(line_len)
    while line_len > 1 do
        turtle.forward()
        line_len = line_len - 1
    end
end

local function dig_square(side_len)
    local lines_to_dig = side_len
    local on_starting_side = true

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

local function get_free_slots()
    local free_slots = 0
    for i = 1, 16 do
        if turtle.getItemCount(i) == 0 then
            free_slots = free_slots + 1
        end
    end
    print("Turtle currently has ".. free_slots .. " free slots.")
    return free_slots
end

function item_in_array(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
end

local function discard_junk()
    local selected_slot = turtle.getSelectedSlot()
    local junk = {"minecraft:cobblestone", "minecraft:andesite", "minecraft:dirt", "minecraft:gravel",
    "minecraft:granite", "minecraft:diorite", "minecraft:cobbled_deepslate", "minecraft:oak_planks",
    "minecraft:netherrack", "minecraft:endstone"}
    for i = 1, 16 do
        turtle.select(i)
        local slot_info = turtle.getItemDetail(i)
        if slot_info and item_in_array(junk, slot_info.name) then
            turtle.drop()
        end
    end
    turtle.select(selected_slot)
end

local function dropAll()
    for i = 1, 16 do
        turtle.select(i)
        turtle.dropUp()
        print("Dropped slot " .. i)
    end
end

local function dig_quarry(side_len, depth, pre_drill)
    local pre_drilled = 0
    while pre_drilled < pre_drill do
        turtle.digDown()
        turtle.down()
        pre_drilled = pre_drilled + 1
    end

    local squares_dug = 0
    while squares_dug < depth do
        dig_square(side_len)
        turtle.digDown()
        turtle.down()
        squares_dug = squares_dug + 1
        discard_junk()

        if (get_free_slots() < 4) then
            local depth_below_surface = pre_drill + squares_dug
            while depth_below_surface > 0 do
                turtle.up()
                depth_below_surface = depth_below_surface - 1
            end
            dropAll()
            return dig_quarry(side_len, depth - squares_dug, pre_drilled + squares_dug)
        end
    end

    depth = depth + pre_drill
    while depth > 0 do
        turtle.up()
        depth = depth - 1
    end
end

dig_quarry(7, 70, 150)
