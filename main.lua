local player = require "src.player"
local tiles = require "src.tiles"
local map = require "src.map"

function love.load()
    tiles.load()
    map.load()
    player.load()
    
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    player.update(dt)
    love.keyboard.keysPressed = {} -- Clear pressed keys after update
end

function love.draw()
    map.draw()
    player.draw()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end
