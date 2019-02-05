--[[
    Script Name:        Anti-Idle
    Description:        Turn your character with random direction to avoid logout.
    Author:             Ascer - example
]]

local MAIN_DELAY = {7, 13}          -- mintues between run antiidle function.
local TURN_DELAY = {200, 450}       -- miliseconds between turn action.
local TURN_TRIES = {1, 5}           -- amount of times to turn.


-- DONT'T EDIT BELOW THIS LINE

local mainTime, turnTime, mainDelay, turnDelay, tries, turnTries, dir = 0, 0, 0, 0, 0, 0

Module.New("Anti-Idle", function ()
    if (os.clock() - mainTime) >= mainDelay then -- check main time
        if turnTries <= 0 then
            turnTries = math.random(TURN_TRIES[1], TURN_TRIES[2]) + 1  -- set random tries
            dir = Self.Direction() -- save start direction
        else
            if (os.clock() - turnTime) >= turnDelay and Self.isConnected() then -- check connection and time
                local dirs = {}
                local direction = Self.Direction()
                for i = 0, 3 do 
                    if (tries + 1) < turnTries then -- insert dirs that different than your current
                        if (3 - i) ~= direction then
                            table.insert(dirs, (3 - i))
                        end
                    else
                        table.insert(dirs, dir) -- on last tries insert your start dir
                    end       
                end
                Self.Turn(dirs[math.random(1, 3)]) -- turn
                turnTime = os.clock()
                turnDelay = math.random(TURN_DELAY[1], TURN_DELAY[2])/1000 -- set a new delay for turn /1000 cuz clock return time in seconds
                tries = tries + 1 
                if tries >= turnTries then -- rest variables
                    tries = 0
                    turnTries = 0
                    mainTime = os.clock()
                    mainDelay = math.random(MAIN_DELAY[1] * 60, MAIN_DELAY[2] * 60)
                end
            end
        end
    end                    
    -- when no mod:Delay(a, b) then run module every 200ms
end) 
