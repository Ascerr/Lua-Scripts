--[[
    Script Name: 		Fast UH Healing
    Description: 		Restore health using uh rune.
    Author: 			Ascer - example
]]

local RUNE_DELAY = 1000				-- time between using rune. Default min delay on use uh is 1000ms
local HPPERC_BELOW = 50             --when your hpperc is below or equal this value
local RUNEID = 3160                 -- UH id 

-- DONT'T EDIT BELOW THIS LINE 

Module.New("Fast UH Healing", function ()
    if Self.HealthPercent() <= HPPERC_BELOW then 
        Self.UseItemWithMe(RUNEID, RUNE_DELAY)
    end            
end)