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
                time = time + 1
            end

            selected[1] = false -- Reset after cast
        end
    end
}




spell[2] = {
    name = "heal",
    effect = function(x, y, aim_x, aim_y)
        print("Casting heal from (" .. x .. ", " .. y .. ")")    
        time = time + 1
    end
}

spell[3] = {
    name = "simple test spell",
    effect = function(x, y, aim_x, aim_y)
        print("simple test spell (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")    
        ime = time + 1
    end
}


return spell
