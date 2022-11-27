local Cells = require("Cells")

local Load = {}

---@alias startType
---|"none"
---|"random"
---|"glider"
---|"blinker"

---@param type startType
function Load.startingConfig(type, width, height)
    if type == "none" then
        for x = 0, (width / Cells.res) - 1 do
            Cells[x] = {}
            for y = 0, (height / Cells.res) - 1 do
                Cells[x][y] = {State = 0, Change = false}
            end
        end
    elseif type == "random" then
        for x = 1, (width/Cells.res)-2 do
            for y = 1, (height/Cells.res)-2 do
                Cells[x][y] = {State = love.math.random(0, 1), Change = false}
            end
        end
    elseif type == "glider" then
        for y = 1, 3 do
            Cells[3][y] = {State = 1, Change = false}
        end
        Cells[1][2] = {State = 1, Change = false}
        Cells[2][3] = {State = 1, Change = false}
    elseif type == "blinker" then
        for x = 1, 3 do
           Cells[x + 8][10] = {State = 1, Change = false}
        end
    end
end

return Load