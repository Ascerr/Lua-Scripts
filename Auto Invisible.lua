--[[
    Script Name: 		Auto Invisible
    Description: 		If no invisible condition then use spell
    Author: 			Ascer - example
]]

local SPELL = {name = "utana vid", mana = 350}


-- DON'T EDIT BELOW THIS LINE

Module.New("Auto Invisible", function (mod)
	if Self.isConnected() then
		if not Self.isInvisible() and Self.Mana() >= SPELL.mana then
			Self.Say(SPELL.name)
		end	
	end
	mod:Delay(500, 1000) -- delay	
end)
