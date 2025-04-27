local map = {}

local player = require "src.player"

function Position()
    love.graphics.print("Player Position: (" .. player.grid_x .. ", " .. player.grid_y .. ")")
end


function map.load()
    square_size = 32 -- you can guess what this does
end

function map.draw()
    local screen_width = love.graphics.getWidth()
    local screen_height = love.graphics.getHeight()
    
    local cols = math.ceil(screen_width / square_size)
    local rows = math.ceil(screen_height / square_size)

    for row = 1, rows do
        for col = 1, cols do
            -- Fill square
            love.graphics.setColor(0.6, 0.6, 0.6) -- Same color for all squares (light gray)
            love.graphics.rectangle("fill", (col-1) * square_size, (row-1) * square_size, square_size, square_size)

            -- Draw outline
            love.graphics.setColor(0, 0, 0) -- Black outline
            love.graphics.rectangle("line", (col-1) * square_size, (row-1) * square_size, square_size, square_size)
        end
    end

    love.graphics.setColor(1, 1, 1) -- Reset color
    Position()
end

return map



