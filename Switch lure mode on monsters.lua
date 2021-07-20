--[[
    Script Name: 		Switch lure mode on monsters
    Description: 		When low amount of monsters enable lure mode, else disable and attack.
    Author: 			Ascer - example
]]

local config = {
	amount = 3,					-- how many monsters to start attack
	range = 7,					-- search monsters in range (7 deafult full screen)
	list = {"Rat", "Spider", }	-- list monsters to search.
}


-- DON'T EDIT BELOW THIS LINE

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

		-- when low amount of monsters
		if monsters < config.amount then

			-- enable lure mode
			if not Walker.isLureModeEnabled() then Walker.setLureMode(true) end

		else
			
			-- disable lure mode
			if Walker.isLureModeEnabled() then Walker.setLureMode(false) end

		end	

	end	

end)
