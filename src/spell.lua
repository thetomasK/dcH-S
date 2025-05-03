local spell = {}
local selected = {}
function range_check(x, y, aim_x, aim_y, range)
    return (x > aim_x + range) or (x < aim_x - range) or (y > aim_y + range) or (y < aim_y - range)
end

-- Fireball spell definition
spell[1] = {
    name = "Fireball",
    effect = function(x, y, aim_x, aim_y)
        -- Select the spell on the first press
        if not selected[1] then
            selected[1] = true
            print("Selected spell: Fireball (press again to cast)")
        else
            -- Check if the aim position is invalid
            if aim_x == 0 or aim_y == 0 then
                print("Invalid aim position! (aim_x or aim_y is 0, you would hit yourself)")
            -- Check if the target is out of range
            elseif range_check(x, y, aim_x, aim_y, 5) then
                print("You are out of reach! (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
            else
                -- Cast the Fireball
                print("Casting Fireball from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                time = time + 1
            end
            -- Reset selection after casting
            selected[1] = false
        end
    end,

}

spell[2]= {
    name = "test",
    effect = function(x, y, aim_x, aim_y)
        print(aim_x,aim_y) -- bitch i am retardet aim x and aim y is bed value
    end

}

return spell
