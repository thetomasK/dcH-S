local ui = {}
local player = require "src.player"
local boldFont -- Declare the bold font variable

function ui.load()
    square_size = 32 -- you can guess what this does
    boldFont = love.graphics.newFont("tiles/asets/fonts/freefont-20080323/FreeMonoBold.otf", 16) -- Load a bold font (adjust path and size)
end

function position()
    love.graphics.setFont(boldFont) -- Apply the bold font
    love.graphics.print("Player position: (" .. grid_x .. ", " .. grid_y .. ")", 10, 0)
end

function stats()
    love.graphics.setFont(boldFont) -- Apply the bold font
    love.graphics.setColor(1, 1, 0) -- Yellow
    love.graphics.print("str:   " .. str,    10, 120)
    love.graphics.print("dex:   " .. dex,    10, 140)
    love.graphics.print("int:   " .. int,    10, 160)
    love.graphics.print("ac:    " .. ac,     10, 180)
    love.graphics.print("sh:    " .. sh,     10, 200)
    love.graphics.print("ev:    " .. ev,     10, 220)
    love.graphics.print("stlh:  " .. stlh,   10, 240)

    love.graphics.setColor(1, 0, 0) -- Red
    love.graphics.print("hp:    " .. hp,     10, 55)

    love.graphics.setColor(0, 1, 0) -- Green
    love.graphics.print("sp:    " .. sp,     10, 75)
    
    love.graphics.setColor(0, 0, 1) -- Blue
    love.graphics.print("mp:    " .. mp,     10, 95)

    love.graphics.setColor(1, 1, 1) -- Reset to white


end

function dungenTime()
    love.graphics.setFont(boldFont) -- Apply the bold font
    love.graphics.print("Dungeon Time: " .. time, 10, 30) 
end

function ui.draw()
    stats()
    position()
    dungenTime()
end

return ui