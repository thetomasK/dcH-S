local ui = {}

local player = require "src.player"

function Position()
    love.graphics.print("Player Position: (" .. player.grid_x .. ", " .. player.grid_y .. ")", 10, 0)
end

function dungenTime()
    love.graphics.print("Dungeon Time: " .. time, 10, 30) 
end

function ui.update(dt)

end

function ui.load()
    square_size = 32 -- you can guess what this does
end

function ui.draw()
    
    Position()
    dungenTime()
end

return ui


