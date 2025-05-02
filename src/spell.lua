local spell = {}

-- Example spell 1
spell[1] = {
    name = "Firebolt",
    effect = function(px, py )
        print("Casting Firebolt at (" .. px .. ", " .. py .. ")")
        -- Add your firebolt logic here (e.g., explosion effect, damage to enemies, etc.)
    end
}

return spell
