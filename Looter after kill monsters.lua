--[[
    Script Name: 		Looter after kill monsters
    Description: 		Loot only when monsters killed already.
    Author: 			Ascer - example
]]

local config = {
	range = 7						-- search monsters in range (7 deafult full screen)
}


-- DON'T EDIT BELOW THIS LINE

local amountReached = false

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMonsters()
--> Description: 	Get amount monsters in specific range.
--> Class: 			Self
-->					
--> Return: 		number monsters amount.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters()

	-- set default count and load target
	local count, target = 0, Self.TargetID()

	-- inside loop for all found creatures do:
	for i, mob in pairs(Creature.iMonsters(config.range, false)) do

		-- increate count
		count = count + 1

		-- when monsters is target add to looting.
		if mob.id == target then Looter.AddCreature(mob) end
		
	end

	-- return monsters amount.
	return count

end	


-- mod to run function in loop 200ms
Module.New("Looter after kill monsters", function ()
	
	-- when connected.
	if Self.isConnected() then

		--load monsters amount
		local monsters = getMonsters()
		
		-- when no monsters
		if monsters <= 0 then

			-- enable looter
			if not Looter.isEnabled() then Looter.Enabled(true) end

		else	

			-- when finished looting
			if not Looter.isLooting() then

				-- disable looter
				if Looter.isEnabled() then Looter.Enabled(false) end

			end	

		end	
			
	end	

end)
