--[[
    Script Name: 		Use UH only if many monsters
    Description: 		Use RUNE_ID with your character when hp drop below, only when many monsters on screen.
    Author: 			Ascer - example
]]

local RUNE_ID = 3160 	                -- id of item to use
local HPPERC_BELOW = 50	                -- if hpperc is below this value
local MONSTERS_AMOUNT = 5               -- how many monsters to heal with uh (default 5 or more)
local IGNORE_LIST = {"Rat", "Snake"}    -- ignore this monsters. name with capital letter


-- DONT'T EDIT BELOW THIS LINE 


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       mobs
--> Description:    Get count monsters on screen
--> Class:          None
--> Params:         
-->                 @list table with creature names

--> Return:         number amount of monsters.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function mobs(list)
    
    -- read creatures
    local creatures, count = Creature.iMonsters(7, false), 0 

    -- in loop for creatures.
    for i = 1, #creatures do

        -- load single creature.
        local creature = creatures[i]

        -- check if valid name
        if not table.find(list, creature.name) then

            -- add count
            count = count + 1

        end
        
    end
   
    -- return count monsters on screen
    return count  

end


-- module to run script in loop 200ms
Module.New("Use UH only if many monsters", function ()
    
    -- when health percent drop below value and startTime is 0, we set config.
    if Self.HealthPercent() <= HPPERC_BELOW then 

        -- when many monsters on screen.
        if mobs(IGNORE_LIST) >= MONSTERS_AMOUNT then

            -- use rune with me to heal from dmg.
            Self.UseItemWithMe(RUNE_ID)

        end 

    end
    
end)