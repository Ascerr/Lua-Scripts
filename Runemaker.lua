--[[
    Script Name:        Runemaker
    Description:        Making runes or cast spell in game. Checking for no blank runes.
    Author:             Ascer - example
]]

local MAIN_DELAY = {400, 1700} 	-- delay in milisecond random actions
local MANA_ABOVE = 80			-- MANA POINTS above this cast spell
local SPELL = "adura vita" 		-- spell to cast

local NO_BLANKS = { 			-- when no blank runes:
	castSpell = true, 			-- cast spell: true/false
	spell = "exura", 			-- spell to cast 
	logout = false 				-- logout true/false
}

-- DONT'T EDIT BELOW THIS LINE

Module.New("Runemaker", function (mod)
	if Self.Mana() >= MANA_ABOVE then
		if string.instr(Proxy.ErrorGetLastMessage(), "magic item to cast") then
			if NO_BLANKS.logout then
				Self.Logout()
				Rifbot.ConsoleWrite("[" .. os.date("%X") .. "] logged due a no more blank runes") -- set message to Rifbot Console.
			else
				if NO_BLANKS.castSpell then
					Self.CastSpell(NO_BLANKS.spell)
				end
			end
			Proxy.ErrorClearMessage() -- we need to clear message manually.		
		else
			Self.CastSpell(SPELL)
		end			
	end			
	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)