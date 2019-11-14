--[[
    Script Name: 		Mana Burn
    Description: 		Use spell to burn mana and train magic level.
    Author: 			Ascer - example
]]


-- LOCAL CONFIG:

local SPELL = "adura vita"
local RANDOM_MANA_TO_USE_SPELL = {100, 122}
local NO_BLANKS_CAST_SPELL = "exura"

-- DON'T EDIT BELOW THIS LINE

local randomMana = 0

Module.New("Small Stone Picker", function (mod)
	if string.instr(Proxy.ErrorGetLastMessage(), "magic item to cast") then
		Self.CastSpell(NO_BLANKS_CAST_SPELL)
		Proxy.ErrorClearMessage() -- we need to clear message manually.	
	end	
	if randomMana <= 0 then
		randomMana = math.random(RANDOM_MANA_TO_USE_SPELL[1], RANDOM_MANA_TO_USE_SPELL[2])
	else
		if Self.Mana() >= randomMana then
			Self.CastSpell(SPELL)
			random = 0
		end	
	end	
end) 