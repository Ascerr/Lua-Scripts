--[[
    Script Name: 		Heal with spell if no monsters
    Description: 		Cast healing spell when no monsters on screen.
    Author: 			Ascer - example
]]

local config = {
	spell = "exura",		-- cast spell 
	hpperc = 90,			-- cast when hpperc below
	mana = 25				-- mana required to cast spell
}


-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMonsters()
--> Description: 	Read creatures for monsters on screen.
--> Class: 			None
--> Params:			None
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters()
	for i, mob in pairs(Creature.iMonsters(7, false)) do
		return true
	end
	return false
end

-- loop module.
Module.New("Heal with spell if no monsters", function ()
	
	-- when health below
	if Self.HealthPercent() < config.hpperc then

		-- when no monsters.
		if not getMonsters() then

			-- cast spell, mana, delay.
			Self.CastSpell(config.spell, config.mana, 500)

		end	

	end

end)
