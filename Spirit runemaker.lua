--[[
    Script Name: 		Spirit runemaker
    Description: 		Make runes based on spirit value (available for specific servers like Elderan).
    Required:			Rifbot version 2.47+ 2022-12-21
    Author: 			Ascer - example
]]

local config = {
	spell = "adori",				-- spell to cast 
	spiritPercent = 90,				-- when spirit percent is equal or above this value character will make rune.
	randomize = {-5, 5},			-- randomize spirit percent while creating runes, ~5%
	castTimes = 1,					-- cast spell once or more.
}

-- DON'T EDIT BELOW THIS LINE

local randPerc = config.spiritPercent + math.random(config.randomize[1], config.randomize[2])

Module.New("Spirit runemaker", function(mod)
	if Self.isConnected() then
		if Self.SpiritPercent() >= randPerc then
			for i = 1, config.castTimes do
				Self.Say(config.spell)
				wait(2200, 3000)
			end
			randPerc = config.spiritPercent + math.random(config.randomize[1], config.randomize[2])
		end	
	end	
	mod:Delay(500, 1000)
end)
