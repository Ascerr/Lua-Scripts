--[[
    Script Name: 		Switch lure mode on monsters
    Description: 		When low amount of monsters enable lure mode, else disable and attack.
    Important:			Walking time for luring you can change in walker -> settings -> lure step time.
    Author: 			Ascer - example
]]

local config = {
	amount = 3,					-- how many monsters to start attack
	range = 7,					-- search monsters in range (7 deafult full screen)
	untildie = true,				-- lure sepecific amount, kill all then start next luring session
	list = {"Black Knight", "Hydra"}		-- list monsters to search.
}


-- DON'T EDIT BELOW THIS LINE

local amountReached = false

config.list = table.lower(config.list)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMonsters()
--> Description: 	Get amount monsters in specific range.
--> Class: 			Self
-->					
--> Return: 		number monsters amount.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters()

	-- set default count
	local count = 0

	-- inside loop for all found creatures do:
	for i, mob in pairs(Creature.iMonsters(config.range, false)) do

		if table.find(config.list, string.lower(mob.name)) then

			-- calsulate monsters.
			count = count + 1

			-- when count is equal to our config break
			if count >= config.amount then break end

		end	

	end

	-- return monsters amount.
	return count

end	


-- mod to run function in loop 200ms
Module.New("Switch lure mode on monsters", function ()
	
	-- when connected.
	if Self.isConnected() then

		--load monsters amount
		local monsters = getMonsters()

		-- when no monsters
		if monsters <= 0 then 
			
			-- reset amount
			amountReached = false

		end	

		-- when low amount of monsters
		if monsters < config.amount then

			-- when disabled untildie destroy reached amount
			if not config.untildie then 
				
				-- reset amount
				amountReached = false 

			end

			-- enable lure mode and not reached amount to kill all
			if not Walker.isLureModeEnabled() and not amountReached then Walker.setLureMode(true) end

		else
			
			-- disable lure mode
			if Walker.isLureModeEnabled() then Walker.setLureMode(false) end

			-- set we reach current amount of monsters
			amountReached = true

		end	

	end	

end)
