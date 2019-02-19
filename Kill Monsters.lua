--[[
    Script Name: 		Kill monsters.
    Description: 		Kill declared monsters with specific runeid 
    Author: 			Ascer - example
]]

local TARGET_LIST = {"Cyclops", "Warlock"} -- add here monster names
local RUNEID = 3155 -- rune have to be visible in containers

-- DONT'T EDIT BELOW THIS LINE

tbl = table.lower(TARGET_LIST)

Module.New("Kill monsters", function (mod)
    for i, mob in pairs(Creature.iMonsters(7, false)) do
        if table.find(tbl, string.lower(mob.name)) then
            Self.UseItemWithCreature(mob, RUNEID) -- use rune with creature.
            wait(500)
            break -- break loop
        end
    end            
end)
