local spell = {}

spell.x = nil
spell.y = nil
spell.size = 0
spell.active = false

function spell.cast(x, y)
    spell.x = x
    spell.y = y
    spell.size = 32
    spell.active = true
end

function spell.update(dt)
    if spell.active then
        spell.size = spell.size + 100 * dt  -- explosion grows over time
        if spell.size > 64 then
            spell.active = false  -- explosion disappears
        end
    end
end

function spell.draw()
    if spell.active then
        love.graphics.setColor(1, 0.5, 0) -- orange
        love.graphics.circle("fill", spell.x + 16, spell.y + 16, spell.size)
        love.graphics.setColor(1, 1, 1) -- reset color
    end
end

return spell