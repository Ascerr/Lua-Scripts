--[[
    Script Name:        SpellMax
    Description:        Cast spell with target id.
    Author:             Ascer - example
]]

local SPELL = "exori con"
local DELAY = 1000

-- DON'T EDIT BELOW

local spellTime = 0 

Module.New("SpellMax", function(mod)
	if os.time() - spellTime > DELAY/1000 then 
		if Self.TargetID() > 0 then
			Self.CastSpell(SPELL)
			spellTime = os.time()
		end	
	end	
end)