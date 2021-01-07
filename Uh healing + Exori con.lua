--[[
    Script Name: 		Uh healing + Exori con
    Description: 		Restore health using uh rune conditional on mana and use exori con only when hp not low.
    Author: 			Ascer - example
]]

local UH = {
	hpperc = 50, 	--> use only if hpperc is below this value
	mana = 50, 		--> use if mana is below this value. Type 999999 if you want ignore mana
	id = 3160, 		--> what rune to use
	delay = 1000	--> use every miliseconds
} 

local SPELL = {
	hpperc = 70,		--> use only if hpperc is above this value
	mana = 50,			--> use only if mana is above this value
	name = "exori con",	--> spell name to cast
	delay = 2000		--> execution delay in miliseconds 1000ms = 1s
}

-- DONT'T EDIT BELOW THIS LINE 

Module.New("Uh healing + Exori con", function ()
    
	-- load hpperc and mana
    local hp = Self.HealthPercent()
    local mp = Self.Mana()
    
    -- when conditions is meet requirements
    if hp <= UH.hpperc and mp <= UH.mana then 
        
        -- use rune with character.
        Self.UseItemWithMe(UH.id, UH.delay)
    
    else

    	-- when we have target.
    	if Self.TargetID() > 0 then

    		-- when conditions is meet requirements
    		if hp >= SPELL.hpperc and mp >= SPELL.mana then

    			-- cast spell
    			Self.CastSpell(SPELL.name, SPELL.mana, SPELL.delay)

    		end	

    	end	

    end 

end)