--[[
    Script Name: 		Auto Mana Shield if no Monsters
    Description: 		When no utamo and no monsters cast mana shield spell
    Author: 			Ascer - example
]]

local SPELL = {name = "utamo vita", mana = 50, delay = 500}		-- @name - spell to cast, @mana - min mana to use, @delay - cast every miliseconds.


-- DON'T EDIT BELOW THIS LINE


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMobs()
--> Description: 	Check for monsters on screen.
--> Params:			None
-->				
--> Return: 		boolean true or false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMobs()

	-- in loop check for monsters on screnn.
	for i = 1, #Creature.iMonsters(7, false) do
		
		-- return true there is monster on screen
		return true	 

	end	

	-- no monsters on screen
	return false

end

-- run in loop.
Module.New("Auto Mana Shield if no Monsters", function ()
	
	-- when connected.
	if Self.isConnected() then

		-- when no monsters
		if not getMobs() then

			-- when no mana shielded.
			if not Self.isManaShielded() then

				-- when mana fine.
				if Self.Mana() >= SPELL.mana then

					-- cast spell.
					Self.CastSpell(SPELL.name, SPELL.mana, SPELL.delay)

				end	

			end	

		end	

	end	

end)
