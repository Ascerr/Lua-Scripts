--[[
    Script Name: 		Haste If skull
    Description: 		Auto haste if skull on screen.
    Author: 			Ascer - example
]]

local SPELL = "utani hur"							-- spell to cast
local IGNORE_PLAYERS = {"friend1", "friend2"}		-- ignore checking this players.

-- DON'T EDIT BELOW THIS LINE

IGNORE_PLAYERS = table.lower(IGNORE_PLAYERS)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getSkulls()
--> Description: 	Read players on screen with skull white and red.

--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getSkulls()
	for i, mob in pairs(Creature.iPlayers(7, false)) do
		if not table.find(IGNORE_PLAYERS, string.lower(mob.name)) and mob.skull >= SKULL_WHITE then
			return true
		end	
	end
	return false
end

-- loop module.
Module.New("Haste If skull", function (mod)
	
	-- when no hasted.
	if not Self.isHasted() then

		-- when skulls.
		if getSkulls() then

			-- cast spell, mana, delay.
			Self.CastSpell(SPELL, 40, 500)

		end	

	end

	-- module delay in miliseconds		
	mod:Delay(200, 400)
	
end)