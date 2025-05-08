local spell = {}
local selected = {}
local fireball_image = love.graphics.newImage("tiles/asets/spells/fireball.png")




-- Variables to store highlight position and range
local highlight_x = nil
local highlight_y = nil
local highlight_range = nil

-- Table to store active spell animations
spell.active_animations = {}

-- Tile size (32px)
local tile_size = 32

-- Cancel keys
local cancelKeys = {
    "kp1", "kp2", "kp3", "kp4", "kp5", "kp6", "kp7", "kp8", "kp9",
    "q", "w", "e", "a", "s", "d", "z", "x", "c", "f"
}

local cancelPrinted = false

-- Utility: Check if any key from a list is currently held down
local function anyKeyDown(keys)
    for _, key in ipairs(keys) do
        if love.keyboard.isDown(key) then
            return true
        end
    end
    return false
end

-- Range check
local function range_check(x, y, aim_x, aim_y, range)
    return (x > aim_x + range) or (x < aim_x - range) or (y > aim_y + range) or (y < aim_y - range)
end

-- Highlight square
local function squareHighlight(x, y, range)
    highlight_x = x
    highlight_y = y
    highlight_range = range
end

-- Add fireball animation
local function fastSpellAnimations(x, y, aim_x, aim_y)
    table.insert(spell.active_animations, {
        type = "fireball",
        x = x + 0.5,  -- Start from the middle of the tile (center)
        y = y + 0.5,  -- Start from the middle of the tile (center)
        aim_x = aim_x + 0.5,  -- Target's middle point
        aim_y = aim_y + 0.5,  -- Target's middle point
        progress = 0,
        speed = 10-- tiles per second
    })
end

-- Fireball spell definition
spell[1] = {
    name = "Fireball",
    range = 5,
    effect = function(x, y, aim_x, aim_y)
        if not selected[1] then
            selected[1] = true
            print("Selected spell: Fireball (press again to cast)")
            squareHighlight(x, y, spell[1].range)
        else
            if aim_x == x and aim_y == y then
                print("Invalid aim position! (you would hit yourself)")
            elseif range_check(x, y, aim_x, aim_y, spell[1].range) then
                print("You are out of reach! (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
            else
                print("Casting Fireball from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                fastSpellAnimations(x - 1, y - 1, aim_x - 1, aim_y -1)
                time = time + 1 -- Assuming 'time' is global
            end
            selected[1] = false
            highlight_x = nil
            highlight_y = nil
            highlight_range = nil
        end
    end
}

-- Update logic
function spell.update(dt)
    -- Cancel logic
    if ((anyKeyDown(cancelKeys) or love.mouse.isDown(1) or love.mouse.isDown(2))) and selected[1] then
        selected[1] = false
        highlight_x = nil
        highlight_y = nil
        highlight_range = nil

        if not cancelPrinted then
            print("Spell selection canceled.")
            cancelPrinted = true
        end
    else
        cancelPrinted = false
    end

    -- Update animations
    for i = #spell.active_animations, 1, -1 do
        local anim = spell.active_animations[i]
       
        local dx = anim.aim_x - anim.x  
        local dy = anim.aim_y - anim.y  
        local dist = math.sqrt(dx * dx + dy * dy)
        if dist < 0.1 then
            table.remove(spell.active_animations, i)
        else
            local norm_x = dx / dist
            local norm_y = dy / dist
            anim.x = anim.x + norm_x * anim.speed * dt
            anim.y = anim.y + norm_y * anim.speed * dt
        end
    end
end

-- Draw highlight and animations
function spell.draw()
    -- Draw spell range highlight
    if highlight_x and highlight_y and highlight_range then
        love.graphics.setColor(1, 1, 0, 0.2)
        local size = (highlight_range * 2 + 1) * tile_size
        local draw_x = (highlight_x - 1 - highlight_range) * tile_size
        local draw_y = (highlight_y - 1 - highlight_range) * tile_size
        love.graphics.rectangle("fill", draw_x, draw_y, size, size)
        love.graphics.setColor(1, 1, 1, 1)
    end

    -- Draw fireball animations
    for _, anim in ipairs(spell.active_animations) do
        if anim.type == "fireball" then
            love.graphics.setColor(1, 1, 1, 1) -- Reset color to normal before drawing the image
            local draw_x = anim.x * tile_size
            local draw_y = anim.y * tile_size
            love.graphics.draw(fireball_image, draw_x, draw_y, 0, 1, 1, fireball_image:getWidth() / 2, fireball_image:getHeight() / 2)
        end
    end
    
    love.graphics.setColor(1, 1, 1, 1)
end

return spell
