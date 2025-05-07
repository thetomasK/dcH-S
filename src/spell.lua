-- spel.lua
local spell = {}
local selected = {}


-- Variables to store highlight position and range
local highlight_x = nil
local highlight_y = nil
local highlight_range = nil

local function range_check(x, y, aim_x, aim_y, range)
    return (x > aim_x + range) or (x < aim_x - range) or (y > aim_y + range) or (y < aim_y - range)
end


local function squareHighlight(x, y, range)
    highlight_x = x
    highlight_y = y
    highlight_range = range
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
            if aim_x == 0 or aim_y == 0 then
                print("Invalid aim position! (aim_x or aim_y is 0, you would hit yourself)")
            elseif range_check(x, y, aim_x, aim_y, spell[1].range) then
                print("You are out of reach! (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
        
            else
                print("Casting Fireball from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                time = time + 1  -- Increment time after the cast
            end
            selected[1] = false
            highlight_x = nil -- Clear highlight after casting
            highlight_y = nil
            highlight_range = nil
        end
    end
}

function spell.update(dt)
    -- Add cooldowns or spell effects here
end

function spell.draw()
    if highlight_x and highlight_y and highlight_range then
        love.graphics.setColor(1, 1, 0, 0.2) -- Red with transparency
        local tile_size = 32
        local size = (highlight_range * 2 + 1) * tile_size
        local draw_x = (highlight_x - 1 - highlight_range ) * tile_size
        local draw_y = (highlight_y - 1 - highlight_range ) * tile_size
        love.graphics.rectangle("fill", draw_x, draw_y, size, size)
        love.graphics.setColor(1, 1, 1, 1) -- Reset to white
    end
end

return spell
