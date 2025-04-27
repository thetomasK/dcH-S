-- src/tiles.lua 

local tiles = {}

local playerImage -- holds the loaded image

function tiles.load()
    playerImage = love.graphics.newImage("tiles/asets/u/human.png")
end

function tiles.draw(x, y)
    if playerImage then
        love.graphics.draw(playerImage, x, y)
    end
end

return tiles

