local spell = {}

-- Example spell 1
local selected = {}

-- Fireball (requires double tap)
spell[1] = {
    name = "Fireball",
    effect = function(x, y, aim_x, aim_y)
        -- Use the selected state from the 'selected' table for each spell
        if not selected[1] then
            print("Selected spell: Fireball (press again to cast)")
            selected[1] = true
        else
            -- Check distance
            local dx = aim_x - x
            local dy = aim_y - y
            local distance = math.sqrt(dx * dx + dy * dy)
            local max_range = 5

            if distance > max_range then
                print("You are out of reach!")
                
            else
                print("Casting Fireball from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                -- Spell effect logic goes here
            end

            selected[1] = false -- Reset after cast
        end
    end
}



-- Example spell 1
spell[2] = {
    name = "blink",
    effect = function(x, y, aim_x, aim_y)
        print("Casting blink from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")    
        -- Add your firebolt logic here (e.g., explosion effect, damage to enemies, etc.)
    end
}


return spell
