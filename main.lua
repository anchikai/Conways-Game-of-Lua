local Load = require("Load")
local Cells = require("Cells")
local Input = require("Input")
local Gamestate = require("Gamestate")

local width, height

---@type love.load
function love.load()
    local icon = love.image.newImageData("icon.png")
    love.window.setMode(1600, 900)
    love.window.setTitle("Conway's Game of Life")
    love.window.setIcon(icon)
    width, height = love.graphics.getDimensions()

    Load.startingConfig("none", width, height)
end

---@type love.update
function love.update(dt)
    Input.update(width, height)
    Cells.update(width, height, dt)
end

---@type love.draw
function love.draw()
    for x = 0, (width/Cells.res)-1 do
        for y = 0, (height/Cells.res)-1 do
            if Cells[x][y].State == 0 then
                love.graphics.rectangle("fill", x * Cells.res, y * Cells.res, Cells.res - Gamestate.showGrid, Cells.res - Gamestate.showGrid)
            end
        end
    end
end