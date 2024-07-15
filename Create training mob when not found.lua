--[[
    Script Name:        Create training mob when not found.
    Description:        When monster with selected name not found near your cast spell to create it.
    Author:             Ascer - example
]]

local SPELL = "!train"				-- spell to cast, to use: "utevo res \"Monk"
local MOB = "Monk"					-- name of creature
local RANGE = 5						-- distance on map to check

--  DON'T EDIT BELOW THIS LINE

Module.New("Create training mob when not found", function (mod)
	if Self.isConnected() then
		local found = false
		for _, mob in ipairs(Creature.iMonsters(RANGE, false)) do
			if string.lower(mob.name) == string.lower(MOB) then
				found = true
			end	
		end
		if not found then
			Self.Say(SPELL)
			wait(1000)
		end	
	end			
	mod:Delay(300, 1200) -- set random delay
end)