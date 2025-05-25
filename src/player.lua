
local spell = require "src.spell"
local camera = require "src.camera"
cam = camera()

local player = {}
time = 0 
player.grid_y = 0
player.grid_x = 0


function player.load()
    playerImage = love.graphics.newImage("tiles/asets/u/human.png")
end

function getMouseGridPosition(square_size)
    local mouse_x, mouse_y = cam:worldCoords(love.mouse.getPosition())
    local aim_x = math.floor(mouse_x / square_size)  -- koooooookt +1
    local aim_y = math.floor(mouse_y / square_size) 
    return aim_x, aim_y
end

local mousePressed = false
function player.update(dt)
    
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

  
    if love.mouse.isDown(1) then -- 2 is the right mouse button
        if not mousePressed then
            local aim_x, aim_y = getMouseGridPosition(square_size)
            function playerDistance(aim_x, aim_y, grid_x, grid_y)
                return math.max(math.abs(aim_x - player.grid_x), math.abs(aim_y - player.grid_y)) -- i think this is caled manhattanDistance google sad that 
            end
            local distance = playerDistance(aim_x, aim_y, player.grid_x, player.grid_y)

            player.grid_x = aim_x
            player.grid_y = aim_y
            time = time + distance --this dont work as it should now it work hihi
            mousePressed = true
        end
    else
        mousePressed = false -- Reset when the button is released
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
    love.graphics.draw(playerImage, draw_x - image_offset, draw_y - image_offset)

    -- Get the grid position the mouse is pointing at
    local aim_x, aim_y = getMouseGridPosition(square_size)

    -- Draw a semi-transparent rectangle to highlight the target square
    love.graphics.setColor(0.5, 0.5, 1, 0.5) -- light blue highlight (you can change this color)
    love.graphics.rectangle("fill", (aim_x ) * square_size, (aim_y ) * square_size, square_size, square_size)

 
end

return player