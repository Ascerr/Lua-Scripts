--[[
    Script Name: 		Cure Para If No Monsters
    Description: 		Cast spell when no monsters on screen and you paralyzed.
    Author: 			Ascer - example
]]

local SPELL = "incuro"		-- spell to cast
local MONSTERS_RANGE = 7 	-- distance from monster to cast spell. (Default 7 cast if no monsters on screen)

-- DON'T EDIT BELOW THIS LINE


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMonsters()
--> Description: 	Read creatures for monsters on screen.
--> Class: 			None
--> Params:			None
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters()
	for i, mob in pairs(Creature.iMonsters(MONSTERS_RANGE, false)) do
		return true
	end
	return false
end

-- loop module.
Module.New("Cure Para If No Monsters", function (mod)
	
	-- when para
	if Self.isParalyzed() then

		-- when no monsters.
		if not getMonsters() then

			-- cast spell, mana, delay.
			Self.CastSpell(SPELL, 25, 500)

		end	

	end

	-- module delay in miliseconds		
	mod:Delay(200, 400)
	
end)
