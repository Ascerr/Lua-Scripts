--[[
    Script Name: 		Spirit runemaker
    Description: 		Make runes based on spirit value (available for specific servers like Elderan).
    Required:			Rifbot version 2.47+ 2022-12-21
    Author: 			Ascer - example
]]

local config = {
	spell = "adori",				-- spell to cast 
	spiritPercent = 90				-- when spirit percent is equal or above this value character will make rune.
}

Module.New("Spirit runemaker", function(mod)
	if Self.isConnected() then
		if Self.SpiritPercent() >= config.spiritPercent then
			Self.Say(config.spell)
		end	
	end	
	mod:Delay(500, 1000)
end)