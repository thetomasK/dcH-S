local player = require "src.player"

local ui = require "src.ui"
local spell = require "src.spell"



-- new shit local mapgen = require "src.mapgen"

local mapgen = require "src.mapgen"
--local testmap = require "src.testmap"



camera = require "src.camera"
cam = camera()


function love.load()
    
    ui.load()
    player.load()
    
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    player.update(dt)
      -- << Call spell logic here
      
    
    spell.update(dt)
    love.keyboard.keysPressed = {}
    cam:lookAt((grid_x - 0) * square_size, (grid_y - 0.5) * square_size)
    

end

function love.draw()
    
    cam:attach()
    mapgen.draw()
    --testmap.draw()  -- Corrected this line to call the draw function of mapgen
    player.draw()
    spell.draw()
    cam:detach()    
    ui.draw() 
       -- << Draw spell visuals here
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

