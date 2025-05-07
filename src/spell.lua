-- spell.lua
local spell = {}
local selected = {}

-- Variables to store highlight position and range
local highlight_x = nil
local highlight_y = nil
local highlight_range = nil

local cancelKeys = {
    "kp1", "kp2", "kp3", "kp4", "kp5", "kp6", "kp7", "kp8", "kp9", -- number keys
    "q", "w", "e", "a", "s", "d", "z", "x", "c" ,"f"  -- directional / grid keys
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
end

-- Draw highlight
function spell.draw()
    if highlight_x and highlight_y and highlight_range then
        love.graphics.setColor(1, 1, 0, 0.2)
        local tile_size = 32
        local size = (highlight_range * 2 + 1) * tile_size
        local draw_x = (highlight_x - 1 - highlight_range) * tile_size
        local draw_y = (highlight_y - 1 - highlight_range) * tile_size
        love.graphics.rectangle("fill", draw_x, draw_y, size, size)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return spell
