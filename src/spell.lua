local spell = {}

-- Example spell 1
spell[1] = {
    name = "Fireball",
    effect = function(x, y, aim_x, aim_y)
        -- Calculate the distance using simple grid distance (e.g., Manhattan or Euclidean)
        local dx = aim_x - x
        local dy = aim_y - y
        local distance = math.sqrt(dx * dx + dy * dy)  -- Euclidean distance

        local max_range = 5  -- You can change this to match your spell's intended range

        if distance > max_range then
            print("You are out of reach!")
        else
            print("Casting Fireball from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
            -- Add your fireball logic here
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
