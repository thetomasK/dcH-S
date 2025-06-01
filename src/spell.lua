local spell = {}
local selected = {}

-- Tile size in pixels
local tile_size = 32

-- Spell names
local spell_names = { "fireball", "iceblast", "conjurationBall"}

-- Image storage
local spell_images = {}
for _, name in ipairs(spell_names) do
    spell_images[name] = love.graphics.newImage("tiles/asets/spells/" .. name .. ".png")
end

-- Active animations
spell.active_animations = {}

-- Highlight variables
local highlight_x = nil
local highlight_y = nil
local highlight_range = nil

-- Cancel keys
local cancelKeys = {
    "kp1", "kp2", "kp3", "kp4", "kp5", "kp6", "kp7", "kp8", "kp9",
    "q", "w", "e", "a", "s", "d", "z", "x", "c", "f"
}

local cancelPrinted = false

-- Helper: Deselect all spells
local function deselectAll()
    for i = 1, #selected do
        selected[i] = false
    end
    highlight_x, highlight_y, highlight_range = nil, nil, nil
end

-- Helper: Any cancel key pressed?
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

-- Set highlight area
local function squareHighlight(x, y, range)
    highlight_x = x
    highlight_y = y
    highlight_range = range
end

-- Spell animation
local function fastSpellAnimations(spell_type, x, y, aim_x, aim_y)
    table.insert(spell.active_animations, {
        type = spell_type,
        x = x + 0.5,
        y = y + 0.5,
        aim_x = aim_x + 0.5,
        aim_y = aim_y + 0.5,
        progress = 0,
        speed = 10
    })
end

local function blink(x, y, aim_x, aim_y)
    local range = 5
    grid_x = x + 1 + math.random(-range, range)
    grid_y = y + 1 + math.random(-range, range)
    deselectAll()
end

-- conjuration


fireball = 1-- elements/conjuration
iceblast = 2-- elements/conjuration

blinkspell = 0 --translocation

heal = 0 -- charms
manaheal = 0 -- charms


conjurationBall = 3 -- conjuration

--[[
    elements
    conjuration 
    hex - debuffs and confuse
    Charms - buffs
    dark magic - good spels that harms u some way 
    necromancy - summoning dead and shit like that 
    translocation - movement magic
]]



-- elements 

spell[conjurationBall] = {
    name = "conjurationBall",
    range = 5,
    effect = function(x, y, aim_x, aim_y)
        if not selected[conjurationBall] then
            deselectAll()
            selected[conjurationBall] = true
            print("Selected spell: conjurationBall (press again to cast)")
            squareHighlight(x, y, spell[conjurationBall].range)
        else
            if aim_x == x and aim_y == y then
                print("Invalid aim position! (you would hit yourself)")
            elseif range_check(x, y, aim_x, aim_y, spell[conjurationBall].range) then
                print("You are out of reach!")
            elseif mp < 1 then
                print("Not enough mana points to cast iceblast!")
            else
                print("Casting conjurationBall from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                fastSpellAnimations("conjurationBall", x , y , aim_x , aim_y )
                time = time + 1 -- assuming global time
                mp = mp - 1 -- assuming player has a 'sp' attribute for spell points
            end
            deselectAll()
        end
    end
}

spell[fireball] = {
    name = "fireball",
    range = 5,
    effect = function(x, y, aim_x, aim_y)
        if not selected[fireball] then
            deselectAll()
            selected[fireball] = true
            print("Selected spell: Fireball (press again to cast)")
            squareHighlight(x, y, spell[fireball].range)
        else
            if aim_x == x and aim_y == y then
                print("Invalid aim position! (you would hit yourself)")
            elseif range_check(x, y, aim_x, aim_y, spell[fireball].range) then
                print("You are out of reach!")
            elseif mp < 1 then
                print("Not enough mana points to cast iceblast!")
            else
                print("Casting Fireball from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                fastSpellAnimations("fireball", x , y , aim_x , aim_y )
                time = time + 1 -- assuming global time
                mp = mp - 1 -- assuming player has a 'sp' attribute for spell points
            end
            deselectAll()
        end
    end
}



spell[iceblast] = {
    name = "iceblast",
    range = 5,
    effect = function(x, y, aim_x, aim_y)
        if not selected[iceblast] then
            deselectAll()
            selected[iceblast] = true
            print("Selected spell: iceblast (press again to cast)")
            squareHighlight(x, y, spell[iceblast].range)
        else
            if aim_x == x and aim_y == y then
                print("Invalid aim position! (you would hit yourself)")
            elseif range_check(x, y, aim_x, aim_y, spell[iceblast].range) then
                print("You are out of reach!")
            elseif mp < 2 then
                print("Not enough mana points to cast iceblast!")
            else
                print("Casting iceblast from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                fastSpellAnimations("iceblast", x , y , aim_x , aim_y )
                time = time + 1 -- assuming global time
                mp = mp - 2
            end
            deselectAll()
        end
    end
}


spell[blinkspell] = {
    --- blink spell
    effect = function(x, y, aim_x, aim_y)
        
        if mp < 2 then
            print("Not enough mana points to cast blink!")
        else
            
            time = time + 1 -- assuming global time
            mp = mp - 2
            blink(x, y, aim_x, aim_y)
            print("u blinked")
        end
        deselectAll()
    end
}

spell[heal] = {
    --- heal spell
    effect = function(x, y, aim_x, aim_y)
        
            if mp < 10 then
                print("Not enough mana points to cast heal!")
            elseif hp == maxhp then
                print("u are fully healed")
            else
                
                time = time + 1 -- assuming global time
                mp = mp - 2
                hp = hp + 10
                print("u are healed")
            end
        if hp > maxhp then
            hp = maxhp
        end
        deselectAll()
    end
}

spell[manaheal] = {
    --- mana he spell
    effect = function(x, y, aim_x, aim_y)
        
        if hp < 11 then
            print("u will die")
        else
            
            time = time + 1 -- assuming global time
            hp = hp - 10
            mp = mp + 5
            print("+ mp")
        end
        deselectAll()
    end
}




-- Update function
function spell.update(dt)
    for i = 1, #selected do
        if selected[i] and (anyKeyDown(cancelKeys) or love.mouse.isDown(1) ) then
            deselectAll()
            if not cancelPrinted then
                print("Spell selection canceled.")
                cancelPrinted = true
            end
            break
        end
    end

    cancelPrinted = false

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

-- Draw function
function spell.draw()
    if highlight_x and highlight_y and highlight_range then
        love.graphics.setColor(1, 1, 0, 0.2)
        local size = (highlight_range * 2 + 1) * tile_size
        local draw_x = (highlight_x  - highlight_range) * tile_size
        local draw_y = (highlight_y  - highlight_range) * tile_size
        love.graphics.rectangle("fill", draw_x, draw_y, size, size)
        love.graphics.setColor(1, 1, 1, 1)
    end

    for _, anim in ipairs(spell.active_animations) do
        local image = spell_images[anim.type]
        if image then
            local draw_x = anim.x * tile_size
            local draw_y = anim.y * tile_size
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(image, draw_x, draw_y, 0, 1, 1, image:getWidth() / 2, image:getHeight() / 2)
        end
    end

    love.graphics.setColor(1, 1, 1, 1)
end

return spell