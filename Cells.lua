local Gamestate = require("Gamestate")

local Cells = {
    res = 20
}

local seconds = 0
local generation = 0

---@param width integer
---@param height integer
---@param dt number
function Cells.update(width, height, dt)
    if not Gamestate.paused then
        seconds = seconds + dt

        if seconds >= 0.05 then
            for x = 1, (width / Cells.res) - 2 do -- Calculate which cells to change
                for y = 1, (height / Cells.res) - 2 do
                    local topRow    = Cells[x - 1][y - 1].State + Cells[x][y - 1].State + Cells[x + 1][y - 1].State
                    local middleRow = Cells[x - 1][y].State + Cells[x + 1][y].State
                    local bottomRow = Cells[x - 1][y + 1].State + Cells[x][y + 1].State + Cells[x + 1][y + 1].State
                    local getNeighborCount = topRow + middleRow + bottomRow
                    if Cells[x][y].State == 1 and (getNeighborCount < 2 or getNeighborCount > 3) or Cells[x][y].State == 0 and getNeighborCount == 3 then
                        Cells[x][y].Change = true
                    end
                end
            end
            for x = 1, (width / Cells.res) - 2 do -- Update them AFTER they are calculated
                for y = 1, (height / Cells.res) - 2 do
                    if Cells[x][y].Change then
                        if Cells[x][y].State == 1 then
                            Cells[x][y].State = 0
                        else
                            Cells[x][y].State = 1
                        end
                        Cells[x][y].Change = false
                    end
                end
            end
            seconds = 0
            generation = generation + 1
        end
    end
end

return Cells