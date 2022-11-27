local Gamestate = require("Gamestate")
local Cells = require("Cells")
local Load  = require("Load")
local Input = {
    lastInput = {}
}

function Input.update(width, height)
    local mouseX, mouseY = love.mouse.getPosition()

    local lmb = love.mouse.isDown(1)
    local rmb = love.mouse.isDown(2)
    local pause = love.keyboard.isDown("escape")
    local grid = love.keyboard.isDown("g")
    local reset = love.keyboard.isDown("r")

    -- Cell Editing
    if lmb then
        for x = 1, (width / Cells.res) - 2 do
            for y = 1, (height / Cells.res) - 2 do
                if mouseX > (x * Cells.res) and mouseY > (y * Cells.res) and mouseX < (x * Cells.res) + Cells.res and mouseY < (y * Cells.res) + Cells.res then
                    if Cells[x][y].State == 0 then
                        Cells[x][y].State = 1
                        Cells[x][y].Change = false
                    end
                end
            end
        end
    elseif rmb then
        for x = 1, (width / Cells.res) - 2 do
            for y = 1, (height / Cells.res) - 2 do
                if mouseX > (x * Cells.res) and mouseY > (y * Cells.res) and mouseX < (x * Cells.res) + Cells.res and mouseY < (y * Cells.res) + Cells.res then
                    if Cells[x][y].State == 1 then
                        Cells[x][y].State = 0
                        Cells[x][y].Change = false
                    end
                end
            end
        end
    end

    -- Pausing
    if pause and not Input.lastInput.pause then
        Gamestate.paused = not Gamestate.paused
    end

    -- Grid Toggle
    if grid and not Input.lastInput.grid then
        if Gamestate.showGrid == 1 then
            Gamestate.showGrid = 0
        else
            Gamestate.showGrid = 1
        end
    end

    -- Resetting the grid
    if reset and not Input.lastInput.reset then
        Load.startingConfig("none", width, height)
    end

    Input.lastInput.lmb = lmb
    Input.lastInput.lmb = rmb
    Input.lastInput.pause = pause
    Input.lastInput.grid = grid
    Input.lastInput.reset = reset
end

return Input