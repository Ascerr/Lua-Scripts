--[[
    Script Name: 		Attack Monster with most HP
    Description: 		Switch target to monster with most hp.
    Author: 			Ascer - example
]]

local TARGET_LIST = {"Snake", "Rat"} -- list of all possible monsters to switch attack with Capital letter.
local RANGE = 1					     -- max distance to search creatures.
local HP_TYPE = 1					 -- type of identify creatures 0 - the highest percent, 1 - the lowest percent

-- DON'T EDIT BELOW THIS LINE

-- convert list o lower case
TARGET_LIST = table.lower(TARGET_LIST)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getCreatureWithHighestHp(list, range)
--> Description: 	Get table with creature of most hpperc to attack.
--> Params:			
-->					@list table with creature names
-->					@range number max distance between you and creature
--> Return: 		table with monster info or -1 if not found.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCreatureWithHighestHp(list, range)
	local creatures = Creature.iMonsters(range, false) 
	local lastHpperc, c = -1, -1
	for i = 1, #creatures do
		local creature = creatures[i]
		if creature.hpperc > lastHpperc and table.find(list, string.lower(creature.name)) then
			c = creature
			lastHpperc = creature.hpperc
		end	
	end
	return c
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getCreatureWithLowestHp(list, range)
--> Description: 	Get table with creature of lowest hpperc to attack.
--> Params:			
-->					@list table with creature names
-->					@range number max distance between you and creature
--> Return: 		table with monster info or -1 if not found.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCreatureWithLowestHp(list, range)
	local creatures = Creature.iMonsters(range, false) 
	local lastHpperc, c = 101, -1
	for i = 1, #creatures do
		local creature = creatures[i]
		if creature.hpperc < lastHpperc and table.find(list, string.lower(creature.name)) then
			c = creature
			lastHpperc = creature.hpperc
		end	
	end
	return c
end

-- module to run function
Module.New("Attack Monster with most HP", function (mod)

	-- when we are connected
	if Self.isConnected() then
        
		-- set param 
		local mob

		-- depent on HP_TYPE read creature with lowest or highest hpperc
		if HP_TYPE == 0 then

			-- load current creature.
			mob = getCreatureWithHighestHp(TARGET_LIST, RANGE)

		else

			-- load current creature.
			mob = getCreatureWithLowestHp(TARGET_LIST, RANGE)

		end	

		-- when mob is different than -1
		if table.count(mob) > 1 then

			-- when current target is different then creature.
			if Self.TargetID() ~= mob.id then

				-- attack creature.
				Creature.Attack(mob.id)

				-- wait some time.
				wait(200, 500)

			end	
					
		end

	end

	-- module execution delay.
	mod:Delay(200, 500)	

end)
