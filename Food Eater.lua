--[[
    Script Name:        Food Eater
    Description:        Eat food in game..
    Author:             Ascer - example
]]

local MAIN_DELAY = {4, 9}          -- mintues between run antiidle function.
local USE_DELAY = {200, 650}       -- miliseconds between use action.
local USE_TRIES = {4, 7}           -- amount of times to use .

local FOOD = {                     -- add your id if need.
    836, 841, 901, 904, 3577, 3578, 3579, 3580, 3581, 3582, 3583, 3584, 3585, 3586, 3587, 3588, 3589, 
    3590, 3591, 3592, 3593, 3594, 3595, 3596, 3597, 3598, 3599, 3600, 3601, 3602, 3606, 3607, 3723, 
    3724, 3725, 3726, 3728, 3729, 3730, 3731, 3732, 5096, 5678, 6125, 6277, 6278, 6392, 6500, 6541, 
    6542, 6543, 6544, 6545, 6569, 6574, 7158, 7159, 7372, 7373, 7375, 8010, 8011, 8012, 8013, 8014, 
    8015, 8017, 8019, 8177, 8197, 10329, 12310, 14085, 17457, 17820, 17821, 21143, 21144, 21146
}


-- DONT'T EDIT BELOW THIS LINE

local mainTime, useTime, mainDelay, useDelay, tries, useTries = 0, 0, 0, 0, 0, 0


----------------------------------------------------------------------------------------------
--> Function:        findFood(foods)
--> Description:     Check equipment and containers for food.
--> Params:          
-->                  @foods - number or table with id of food.
--> Returns:         number id of item or 0
----------------------------------------------------------------------------------------------
function findFood(foods)
    if type(foods) ~= "table" then -- create table if not.
        foods = {foods}
    end 
    
    local eq = {
        Self.Weapon(),   -- slots in eq
        Self.Shield(), 
        Self.Ammo()
    } 
    
    for i = 1, #eq do -- check for id in equipment
        local item = eq[i]
        if table.find(foods, item.id) then
            return item.id
        end    
    end

    local items = Container.getItems() -- load all items in containers
    for i = 1, #items do
        local container = items[i]
        local contItems = container.items
        for slot = 1, #contItems do
            local item = contItems[slot]
            if table.find(foods, item.id) then
                return item.id
            end
        end
    end
    
    return 0 -- return 0 (food not found)              
end

-- mod to run functions
Module.New("Eat Food", function (mod)
    if (os.clock() - mainTime) >= mainDelay then -- check for main func time
        if useTries <= 0 then
            useTries = math.random(USE_TRIES[1], USE_TRIES[2]) -- set random tries
        else
            if (os.clock() - useTime) >= useDelay and Self.isConnected() then -- check for time and connection
                local food = findFood(FOOD)
                if food > 0 then -- use only if food found, delay set default for release loop reading items.
                    selfUseItem(food, false, 0)
                end    
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
