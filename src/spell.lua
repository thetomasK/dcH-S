local spell = {}
local selected = {}

-- Tile size in pixels
local tile_size = 32

-- Spell names
local spell_names = { "fireball", "iceblast" }

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

-- Fireball spell
table.insert(spell, {
    name = "fireball",
    range = 5,
    effect = function(x, y, aim_x, aim_y)
        if not selected[1] then
            deselectAll()
            selected[1] = true
            print("Selected spell: Fireball (press again to cast)")
            squareHighlight(x, y, spell[1].range)
        else
            if aim_x == x and aim_y == y then
                print("Invalid aim position! (you would hit yourself)")
            elseif range_check(x, y, aim_x, aim_y, spell[1].range) then
                print("You are out of reach!")
            else
                print("Casting Fireball from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                fastSpellAnimations("fireball", x - 1, y - 1, aim_x - 1, aim_y - 1)
                time = time + 1 -- assuming global time
            end
            deselectAll()
        end
    end
})

-- Iceblast spell
table.insert(spell, {
    name = "iceblast",
    range = 4,
    effect = function(x, y, aim_x, aim_y)
        if not selected[2] then
            deselectAll()
            selected[2] = true
            print("Selected spell: Iceblast (press again to cast)")
            squareHighlight(x, y, spell[2].range)
        else
            if aim_x == x and aim_y == y then
                print("Invalid aim position! (you would hit yourself)")
            elseif range_check(x, y, aim_x, aim_y, spell[2].range) then
                print("You are out of reach!")
            else
                print("Casting Iceblast from (" .. x .. ", " .. y .. ") to (" .. aim_x .. ", " .. aim_y .. ")")
                fastSpellAnimations("iceblast", x - 1, y - 1, aim_x - 1, aim_y - 1)
                time = time + 1
            end
            deselectAll()
        end
    end
})

-- Update function
function spell.update(dt)
    for i = 1, #selected do
        if selected[i] and (anyKeyDown(cancelKeys) or love.mouse.isDown(1) or love.mouse.isDown(2)) then
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
        local draw_x = (highlight_x - 1 - highlight_range) * tile_size
        local draw_y = (highlight_y - 1 - highlight_range) * tile_size
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
