--[[
    Script Name:        Eat Food Around You
    Description:        Eat food near your character.
    Author:             Ascer - example
]]

local MAIN_DELAY = {4, 9}          -- mintues between run antiidle function.
local USE_DELAY = {200, 650}       -- miliseconds between use action.
local USE_TRIES = {4, 7}           -- amount of times to use.
local REMOVE_TRASH = false         -- remove trash under your character if cover food

local FOOD_IDS = {3725, 3577}      -- food id

-- DONT'T EDIT BELOW THIS LINE

local mainTime, useTime, mainDelay, useDelay, tries, useTries = 0, 0, 0, 0, 0, 0

-- mod to run functions
Module.New("Eat Food Around You", function (mod)
    if (os.clock() - mainTime) >= mainDelay then -- check for main func time
        if useTries <= 0 then
            useTries = math.random(USE_TRIES[1], USE_TRIES[2]) -- set random tries
        else
            if (os.clock() - useTime) >= useDelay and Self.isConnected() then -- check for time and connection
                local pos = Self.Position()
                for x = -1, 1 do
                    for y = -1, 1 do
                        local items = Map.GetItems(pos.x + x, pos.y + y, pos.z)
                        for i, item in ipairs(items) do
                            if table.find(FOOD_IDS, item.id) then
                                local top = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)
                                if not table.find(FOOD_IDS, top.id) then
                                    if not REMOVE_TRASH then break end
                                    Map.MoveItem(pos.x + x, pos.y + y, pos.z, pos.x, pos.y, pos.z, top.id, top.count, 200)
                                else    
                                    Map.UseItem(pos.x + x, pos.y + y, pos.z, top.id, 1, 0) -- 0 is delay
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
                                break
                            end
                        end        
                    end
                end    
            end
        end
    end                    
    mod:Delay(200, 350)
end) 
