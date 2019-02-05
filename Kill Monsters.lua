--[[
    Script Name: 		Kill monsters.
    Description: 		Kill declared monsters with specific runeid 
    Author: 			Ascer - example
]]

local TARGET_LIST = {"Cyclops", "wolf"} -- add here monster names
local RUNEID = 3155 -- rune have to be visible in containers
local MAIN_DELAY = {2000, 3000} -- random delay using rune with creatures

-- DONT'T EDIT BELOW THIS LINE

tbl = table.lower(TARGET_LIST)

Module.New("Kill monsters", function (mod)
    for i, mob in pairs(Creature.getCreatures()) do
        if table.find(tbl, string.lower(mob.name)) then
            Self.UseItemWithCreature(mob, RUNEID) -- use rune with creature.
            break -- break loop
        end
    end            
    mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2])
end)