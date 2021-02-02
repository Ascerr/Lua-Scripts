--[[
    Script Name: 		Fast UH Healing
    Description: 		Restore health using uh rune.
    Author: 			Ascer - example
]]

local RUNE_DELAY = 1000				-- time between using rune. Default min delay on use uh is 1000ms
local HPPERC_BELOW = 50             --when your hpperc is below or equal this value
local RUNEID = 3160                 -- UH id 
local USE_ONLY_IF_MANA_BELOW = {enabled = false, mana = 160}  -- use uh only if you have low mana. @enabled - true/false, @mana - use if mana below this value

-- DONT'T EDIT BELOW THIS LINE 

-- module to run in loop 200ms
Module.New("Fast UH Healing", function ()
    
	-- when connected
    if Self.isConnected() then
		
		-- check if mana enabled
		local var = (USE_ONLY_IF_MANA_BELOW.enabled and Self.Mana() <= USE_ONLY_IF_MANA_BELOW.mana) or not USE_ONLY_IF_MANA_BELOW.enabled
	    
		-- check for hpperc.
	    if Self.HealthPercent() <= HPPERC_BELOW and var then 
	        Self.UseItemWithMe(RUNEID, RUNE_DELAY)
	    end

	end 

end)
