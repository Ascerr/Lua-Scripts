--[[
    Script Name:        Eat Food On Trainers
    Description:        Eat food in location near your character.
    Author:             Ascer - example
]]

local MAIN_DELAY = {4, 9}          -- mintues between run antiidle function.
local USE_DELAY = {200, 650}       -- miliseconds between use action.
local USE_TRIES = {4, 7}           -- amount of times to use .
local EAT_POS = {x = 0, y = -1, stack = 2}    -- @x, y: positions of food from your character. @stack - index of item on square.

local FOOD_ID = 3725                -- food id

-- DONT'T EDIT BELOW THIS LINE

local mainTime, useTime, mainDelay, useDelay, tries, useTries = 0, 0, 0, 0, 0, 0

-- mod to run functions
Module.New("Eat Food On Trainers", function (mod)
    if (os.clock() - mainTime) >= mainDelay then -- check for main func time
        if useTries <= 0 then
            useTries = math.random(USE_TRIES[1], USE_TRIES[2]) -- set random tries
        else
            if (os.clock() - useTime) >= useDelay and Self.isConnected() then -- check for time and connection
                local pos = Self.Position()
                Map.UseItem(pos.x + EAT_POS.x, pos.y + EAT_POS.y, pos.z, FOOD_ID, EAT_POS.stack, 0) -- 0 is delay
                useTime = os.clock()
                useDelay = math.random(USE_DELAY[1], USE_DELAY[2])/1000
                tries = tries + 1
                if tries >= useTries then
                    tries = 0
                    useTries = 0
                    mainTime = os.clock()
                    mainDelay = math.random(MAIN_DELAY[1] * 60, MAIN_DELAY[2] * 60)
                end
            end
        end
    end                    
    mod:Delay(200, 350)
end) 
