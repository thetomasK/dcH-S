local ui = {}
local player = require "src.player"
local boldFont -- Declare the bold font variable
local menuOpen = false -- Track if the menu is open

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

function drawMenu()
    love.graphics.setFont(boldFont)
    love.graphics.setColor(0, 0, 0, 0.8) -- Semi-transparent black background
    love.graphics.rectangle("fill", 50, 50, 300, 600)
    love.graphics.setColor(1, 1, 1) -- White text
    love.graphics.print("Menu :", 60, 60)
    love.graphics.print("1. fight: " .. fight, 60, 100)
    love.graphics.print("swords: " .. swords, 60, 120)
    love.graphics.print("daggers: " .. daggers, 60, 140)
    love.graphics.print("mace: " .. mace, 60, 160)
    love.graphics.print("axes: " .. axes, 60, 180)
    love.graphics.print("polearms: " .. polearms, 60, 200)

    love.graphics.print("2. magic: " .. magic, 60, 240)
    love.graphics.print("elements: " .. elements, 60, 260)
    love.graphics.print("conjuration: " .. conjuration, 60, 280)
    love.graphics.print("charms: " .. charms, 60, 300)
    love.graphics.print("dark magic: " .. dark_magic, 60, 320)
    love.graphics.print("necromancy: " .. necromancy, 60, 340)
    love.graphics.print("translocation: " .. translocation, 60, 360)
    love.graphics.print("alchemy: " .. alchemy, 60, 380)
    love.graphics.print("magic crafts: " .. magic_crafts, 60, 400)
    love.graphics.print("faith: " .. faith, 60, 420)

    love.graphics.print("3. movement: " .. movement, 60, 460)
    love.graphics.print("dmg skills: " .. dmg_skills, 60, 480)
    love.graphics.print("evasion skills: " .. evasion_skills, 60, 500)
    love.graphics.print("tricks: " .. tricks, 60, 520)
    love.graphics.print("anti magic: " .. anti_magic, 60, 540)

    love.graphics.print("tipe m to leave menu: " , 60, 580)

end

function ui.update()
    if love.keyboard.isDown("m") then
        menuOpen = not menuOpen -- Toggle menu state
        love.timer.sleep(0.2) -- Prevent rapid toggling
    end
end

function ui.draw()
    if menuOpen then
        drawMenu()
    else
        stats()
        position()
        dungenTime()
    end
end

return ui