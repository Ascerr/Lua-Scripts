--[[
    Script Name:        No Soul Cast Spell
    Description:        Cast spell when no more soul points.
    Author:             Ascer - example
]]

local MAIN_DELAY = {400, 1700} 	-- delay in milisecond random actions
local MANA_ABOVE = 160			-- MANA POINTS above this cast spell
local SPELL = "exura vita" 		-- spell to cast



-- DONT'T EDIT BELOW THIS LINE

Module.New("No Soul Cast Spell", function (mod)
	if Self.Mana() >= MANA_ABOVE then
		if string.instr(Proxy.ErrorGetLastMessage(), "soul points") then
			Self.CastSpell(SPELL)
			Proxy.ErrorClearMessage() -- we need to clear message manually.		
		end
	end			
	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)