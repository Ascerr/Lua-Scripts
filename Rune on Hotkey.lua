--[[
    Script Name: 		Rune on Hotkey.
    Description: 		Load script and use rune with hotkey on creature then unload.
    Required:           Don't execute script in lua, go to Rifbot->Shortkeys and set e.g for key F1 command: execute Rune on Hotkey  
    Author: 			Ascer - example
]]

local RUNEID = 3198 -- rune have to be visible in containers (default hmm)
local DELAY = 1000  -- time between using rune in miliseconds !Warring this delay may block your healing with runes on pannel.

-- DONT'T EDIT BELOW THIS LINE

local tid = Self.TargetID()

if tid > 0 then
    for i, mob in pairs(Creature.iCreatures(7, false)) do
        if mob.id == tid then
            Self.UseItemWithCreature(mob, RUNEID, DELAY) -- use rune with creature.
            break -- break loop
        end    
    end
end                
