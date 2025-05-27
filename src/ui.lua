local ui = {}
local player = require "src.player"
local boldFont -- Declare the bold font variable

function ui.load()
    square_size = 32 -- you can guess what this does
    boldFont = love.graphics.newFont("tiles/asets/fonts/freefont-20080323/FreeMonoBold.otf", 16) -- Load a bold font (adjust path and size)
end

function position()
    love.graphics.setFont(boldFont) -- Apply the bold font
    love.graphics.print("Player position: (" .. player.grid_x .. ", " .. player.grid_y .. ")", 10, 0)
end

function stats()
    love.graphics.setFont(boldFont) -- Apply the bold font
    love.graphics.setColor(1, 1, 0) -- Yellow
    love.graphics.print("str:   " .. player.str,    10, 70)
    love.graphics.print("dex:   " .. player.dex,    10, 90)
    love.graphics.print("int:   " .. player.int,    10, 110)
    love.graphics.print("ac:    " .. player.ac,     10, 130)
    love.graphics.print("sh:    " .. player.sh,     10, 150)
    love.graphics.print("ev:    " .. player.ev,     10, 170)
    love.graphics.print("stlh:  " .. player.stlh,   10, 190)

    love.graphics.setColor(1, 0, 0) -- Red
    love.graphics.print("hp:    " .. player.hp,     10, 210)

    love.graphics.setColor(0, 1, 0) -- Green
    love.graphics.print("mp:    " .. player.mp,     10, 230)

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