local player = require "src.player"
local tiles = require "src.tiles"
local map = require "src.map"
local position = require "src.map"


function love.load()
    tiles.load()
    map.load()
    player.load()
    position.load()

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    player.update(dt)
    love.keyboard.keysPressed = {} -- Clear pressed keys after update
end

function love.draw()
    map.draw()
    player.draw()
    position.load()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end
