--[[
    Script Name: 		Haste If No Monsters
    Description: 		Cast haste spell when no monsters on screen.
    Author: 			Ascer - example
]]

local SPELL = "utani hur"							-- spell to cast
local IGNORE_MOBS = {"rat", "snake", "rabbit"}		-- ignore checking this monsters.

-- DON'T EDIT BELOW THIS LINE

IGNORE_MOBS = table.lower(IGNORE_MOBS)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMonsters()
--> Description: 	Read creatures for monsters on screen.
--> Class: 			None
--> Params:			None
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters()
	for i, mob in pairs(Creature.iMonsters(7, false)) do
		if not table.find(IGNORE_MOBS, string.lower(mob.name)) then
			return true
		end	
	end
	return false
end

-- loop module.
Module.New("Haste If No Monsters", function (mod)
	
	-- when no hasted.
	if not Self.isHasted() then

		-- when no monsters.
		if not getMonsters() then

			-- cast spell, mana, delay.
			Self.CastSpell(SPELL, 40, 500)

		end	

	end

	-- module delay in miliseconds		
	mod:Delay(200, 400)
	
end)
