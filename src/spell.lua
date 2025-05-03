local spell = {}
local selected = {}
local time = 0

spell[1] = {
    name = "Fireball",
    effect = function(x, y, aim_x, aim_y)
        if not selected[1] then
            selected[1] = true
            print("Selected spell: Fireball (press again to cast)")
        else
            if aim_x == 0 or aim_y == 0 then
                print("Invalid aim position! (aim_x or aim_y is 0 u would hit your self dummy)")
            elseif x > aim_x * 5 or x < aim_x / 5 or y > aim_y * 5 or y < aim_y / 5 then
                print("You are out of reach!(" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
            else
                print("Casting Fireball from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                time = time + 1
            end
            selected[1] = false
        end
    end,

}


return spell
