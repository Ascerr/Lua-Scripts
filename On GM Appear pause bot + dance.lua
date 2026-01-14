--[[
    Script Name: 		On GM Appear pause bot + dance
    Description: 		When GM appear on screen what is rare, pause bot and dance for 10s, enable bot back within 60s.
    Author: 			Ascer - example
]]

local GM_KEYWORDS = {"GM ", "CM ", "ADM "} 					-- search this keywords
local DANCE = true											-- dance if GM appear for ~10s
local ENABLE_BACK_AFTER = 60								-- enable bot after 60s.

-- DON'T EDIT BELOW

local foundTime, tries = -1, 0

function isGM(name)
	for i = 1, #GM_KEYWORDS do
		if GM_KEYWORDS[i] == string.sub(name, 1, string.len(GM_KEYWORDS[i])) then return true end
	end	
end

Module.New("On GM Appear pause bot + dance", function()
	if Self.isConnected() then
		if foundTime > 0 then
			if tries < 30 then
				Self.Turn(math.random(0, 3))
				tries = tries + 1
			end	
			wait(200, 400)
			if os.clock() - foundTime >= ENABLE_BACK_AFTER then
				foundTime = -1
				tries = 0
				Rifbot.setEnabled(true)
			end	
		end	
		for _, c in ipairs(Creature.iPlayers(7, false)) do
			if isGM(c.name) then
				foundTime = os.clock()
				if Rifbot.isEnabled() then Rifbot.setEnabled(false) wait(2000) end
			end	
		end	
	end	
end)