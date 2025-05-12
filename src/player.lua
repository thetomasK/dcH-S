local tiles = require "src.tiles"
local spell = require "src.spell"

local player = {}
time = 0 
player.grid_y = 0
player.grid_x = 0


function player.load()
end

function getMouseGridPosition(square_size)
    local mouse_x, mouse_y = love.mouse.getPosition()
    local aim_x = math.floor(mouse_x / square_size)  -- koooooookt +1
    local aim_y = math.floor(mouse_y / square_size) 
    return aim_x, aim_y
end


function player.update(dt)
    -- Handle mouse input as before
    if love.mouse.isDown(1) then
        local mouse_x, mouse_y = love.mouse.getPosition()
        local hover_x = math.floor(mouse_x / square_size) 
        local hover_y = math.floor(mouse_y / square_size) 

        -- Check if the player clicked a new position
        if hover_x ~= last_hover_x or hover_y ~= last_hover_y then
            -- Calculate how many rows (Y) and columns (X) you've moved
            local row_difference = math.abs(hover_y - player.grid_y)
            local col_difference = math.abs(hover_x - player.grid_x)

            -- Increment time for each row and column moved
            for i = 1, row_difference do
                time = time + 1
            end

            for i = 1, col_difference do
                time = time + 1
            end

            -- Set the player's grid position to the new clicked position
            player.grid_x = hover_x
            player.grid_y = hover_y

            -- Update the last hover position
            last_hover_x = hover_x
            last_hover_y = hover_y
        end
    else
        last_hover_x = nil
        last_hover_y = nil
    end
    
    -- Handle Numpad and WASD + xz movement as before
    if love.keyboard.wasPressed("kp6") or love.keyboard.wasPressed("d") then
        player.grid_x = player.grid_x + 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp4") or love.keyboard.wasPressed("a") then
        player.grid_x = player.grid_x - 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp2") or love.keyboard.wasPressed("s") then
        player.grid_y = player.grid_y + 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp8") or love.keyboard.wasPressed("w") then
        player.grid_y = player.grid_y - 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp3") or love.keyboard.wasPressed("x") then
        player.grid_x = player.grid_x + 1
        player.grid_y = player.grid_y + 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp1") or love.keyboard.wasPressed("z") then
        player.grid_x = player.grid_x - 1
        player.grid_y = player.grid_y + 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp9") or love.keyboard.wasPressed("e") then
        player.grid_x = player.grid_x + 1
        player.grid_y = player.grid_y - 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp7") or love.keyboard.wasPressed("q") then
        player.grid_x = player.grid_x - 1
        player.grid_y = player.grid_y - 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp5") then
        time = time + 1
    end
    
    -- Handle number keys 0-9 for spellcasting
    for i = 0, 9 do
        local key = tostring(i)
        if love.keyboard.wasPressed(key) then
            local selected_spell = spell[i]
            if selected_spell then
                local aim_x, aim_y = getMouseGridPosition(square_size)
                selected_spell.effect(player.grid_x, player.grid_y, aim_x, aim_y)
            end
        end
    end
end
function player.draw()
    -- Calculate the player's center position based on grid
    local draw_x = (player.grid_x ) * square_size + square_size / 2
    local draw_y = (player.grid_y ) * square_size + square_size / 2

    local image_offset = 16

    -- Draw the player at the current position
    tiles.draw(draw_x - image_offset, draw_y - image_offset)

    -- Get the grid position the mouse is pointing at
    local aim_x, aim_y = getMouseGridPosition(square_size)

    -- Draw a semi-transparent rectangle to highlight the target square
    love.graphics.setColor(0.5, 0.5, 1, 0.5) -- light blue highlight (you can change this color)
    love.graphics.rectangle("fill", (aim_x ) * square_size, (aim_y ) * square_size, square_size, square_size)

 
end

return player