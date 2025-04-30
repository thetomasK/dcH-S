local tiles = require "src.tiles"

local player = {}
time = 0 

function player.load()
    player.grid_x = 3
    player.grid_y = 3
end

function player.update(dt)
    if love.mouse.isDown(1) then
        local mouse_x, mouse_y = love.mouse.getPosition()
        local hover_x = math.floor(mouse_x / square_size) + 1
        local hover_y = math.floor(mouse_y / square_size) + 1

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
    -- Mouse click detection 
    -- Numpad 
    if love.keyboard.wasPressed("kp6") then
        player.grid_x = player.grid_x + 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp4") then
        player.grid_x = player.grid_x - 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp2") then
        player.grid_y = player.grid_y + 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp8") then
        player.grid_y = player.grid_y - 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp3") then
        player.grid_x = player.grid_x + 1
        player.grid_y = player.grid_y + 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp1") then
        player.grid_x = player.grid_x - 1
        player.grid_y = player.grid_y + 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp9") then
        player.grid_x = player.grid_x + 1
        player.grid_y = player.grid_y - 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp7") then
        player.grid_x = player.grid_x - 1
        player.grid_y = player.grid_y - 1
        time = time + 1

    elseif love.keyboard.wasPressed("kp5") then
        time = time + 1

        -- waste turn
    end
end

function player.draw()
    -- Calculate the player's center position based on grid
    local draw_x = (player.grid_x - 1) * square_size + square_size / 2
    local draw_y = (player.grid_y - 1) * square_size + square_size / 2

    local image_offset = 16

    -- Draw the playerr at the current position
    tiles.draw(draw_x - image_offset, draw_y - image_offset)

    -- Highlight the square the player is look at
    local mouse_x, mouse_y = love.mouse.getPosition()
    local aim_x = math.floor(mouse_x / square_size)
    local aim_y = math.floor(mouse_y / square_size)

    -- Draw a semi-transparent rectangle to highlight the target square
    love.graphics.setColor(0.5, 0.5, 1, 0.5) -- transparency(light blue i thing i will change it to yelow or something diff)
    love.graphics.rectangle("fill", aim_x * square_size, aim_y * square_size, square_size, square_size)

    -- Reset color to default
    love.graphics.setColor(1, 1, 1)
    
end

return player
