local tiles = require "src.tiles"

local player = {}

function player.load()
    player.grid_x = 3
    player.grid_y = 3
end

function player.update(dt)
    -- Mouse click detection 
    if love.mouse.isDown(1) then
        -- Get mouse position 
        local mouse_x, mouse_y = love.mouse.getPosition()

        -- Convert mouse position to grid position 
        player.grid_x = math.floor(mouse_x / square_size) + 1
        player.grid_y = math.floor(mouse_y / square_size) + 1
    end

    -- Numpad 
    if love.keyboard.wasPressed("kp6") then
        player.grid_x = player.grid_x + 1
    elseif love.keyboard.wasPressed("kp4") then
        player.grid_x = player.grid_x - 1
    elseif love.keyboard.wasPressed("kp2") then
        player.grid_y = player.grid_y + 1
    elseif love.keyboard.wasPressed("kp8") then
        player.grid_y = player.grid_y - 1
    elseif love.keyboard.wasPressed("kp3") then
        player.grid_x = player.grid_x + 1
        player.grid_y = player.grid_y + 1
    elseif love.keyboard.wasPressed("kp1") then
        player.grid_x = player.grid_x - 1
        player.grid_y = player.grid_y + 1
    elseif love.keyboard.wasPressed("kp9") then
        player.grid_x = player.grid_x + 1
        player.grid_y = player.grid_y - 1
    elseif love.keyboard.wasPressed("kp7") then
        player.grid_x = player.grid_x - 1
        player.grid_y = player.grid_y - 1
    elseif love.keyboard.wasPressed("kp5") then
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
