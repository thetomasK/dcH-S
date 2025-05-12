local map = {}
local mapgen = require "src.mapgen"
local player = require "src.player"

function Position()
    love.graphics.print("Player Position: (" .. player.grid_x .. ", " .. player.grid_y .. ")", 10, 0)
end

function dungenTime()
    love.graphics.print("Dungeon Time: " .. time, 10, 30) 
end

function map.load()
    square_size = 32 -- you can guess what this does
end

function map.draw()
    -- mapgen.draw()  -- Corrected this line to call the draw function of mapgen
    Position()
    dungenTime()
end

return map


