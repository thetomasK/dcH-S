-- mapgen.lua
local player = require "src.player"
local mapgen = {}

-- Size of each square tile in pixels
mapgen.square_size = 32

-- Tile definitions
-- 0 = floor, 1 = wall, 2 = water
mapgen.tile_types = {
    { id = 0, color = {0.8, 0.8, 0.7} }, -- floor (light beige)
    { id = 1, color = {0.2, 0.2, 0.2} }, -- wall (dark gray)
    { id = 2, color = {0.3, 0.5, 0.9} }, -- water (blue)
}

-- Dungeon generation parameters
mapgen.room_min_size  = 4
mapgen.room_max_size  = 8
mapgen.room_count     = 10
mapgen.water_chance   = 0.02  -- 2% chance to place water on floor tiles

-- Internal state (map data and dimensions)
mapgen.cols = 0
mapgen.rows = 0
mapgen.map  = {}

-- Carve a rectangular room of floor tiles into the map
local function carve_room(mx, x1, y1, w, h)
    for y = y1, y1 + h - 1 do
        for x = x1, x1 + w - 1 do
            mx[y][x] = 0 -- floor tile
        end
    end
end

-- Carve an L-shaped tunnel connecting two points
local function carve_tunnel(mx, x1, y1, x2, y2)
    local cx, cy = x1, y1
    -- horizontal segment first
    while cx ~= x2 do
        mx[cy][cx] = 0
        cx = cx + (x2 > cx and 1 or -1)
    end
    -- vertical segment next
    while cy ~= y2 do
        mx[cy][cx] = 0
        cy = cy + (y2 > cy and 1 or -1)
    end
end

-- Generate the dungeon map
function mapgen.generate(cols, rows)
    mapgen.cols = cols
    mapgen.rows = rows

    -- Fill the entire map with walls (default tile)
    local mx = {}
    for y = 1, rows do
        mx[y] = {}
        for x = 1, cols do
            mx[y][x] = 1 -- wall
        end
    end

    -- Generate random rooms and add them to the map
    local rooms = {}
    for i = 1, mapgen.room_count do
        local rw = love.math.random(mapgen.room_min_size, mapgen.room_max_size)
        local rh = love.math.random(mapgen.room_min_size, mapgen.room_max_size)
        local rx = love.math.random(2, cols - rw - 1)
        local ry = love.math.random(2, rows - rh - 1)
        carve_room(mx, rx, ry, rw, rh)
        table.insert(rooms, { x = rx + math.floor(rw / 2), y = ry + math.floor(rh / 2) })
    end

    -- Connect rooms with L-shaped tunnels
    for i = 2, #rooms do
        local a, b = rooms[i - 1], rooms[i]
        carve_tunnel(mx, a.x, a.y, b.x, b.y)
    end

    -- Randomly place water tiles on some floor spaces
    for y = 1, rows do
        for x = 1, cols do
            if mx[y][x] == 0 and love.math.random() < mapgen.water_chance then
                mx[y][x] = 2 -- water
            end
        end
    end

    -- Place the player at the center of the first room
    if #rooms > 0 then
        local start = rooms[1]
        mx[start.y][start.x] = 0
        grid_x = start.x
        grid_y = start.y
    end

    mapgen.map = mx
end

-- Draw the dungeon on the screen
function mapgen.draw()
    -- If no map exists yet, generate one
    if mapgen.cols == 0 then
        local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
        
        -- CHANGED: Add padding (+2) to columns and rows so dungeon does NOT stop exactly at screen edges
        -- This prevents cutoff and allows a buffer of extra tiles
        local c = math.ceil(sw / mapgen.square_size) + 2 -- changed line
        local r = math.ceil(sh / mapgen.square_size) + 2 -- changed line
        
        mapgen.generate(c, r)
    end

    local sz = mapgen.square_size
    for y = 1, mapgen.rows do
        for x = 1, mapgen.cols do
            local t = mapgen.map[y][x]
            local col = mapgen.tile_types[t + 1].color
            love.graphics.setColor(col)
            love.graphics.rectangle("fill", (x - 1) * sz, (y - 1) * sz, sz, sz)

            -- Draw black outlines on walls
            if t == 1 then
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("line", (x - 1) * sz, (y - 1) * sz, sz, sz)
            end
        end
    end
    love.graphics.setColor(1, 1, 1) -- reset color
end

return mapgen 