--[[
    Script Name: 		Attack Skulls
    Description: 		Change target between creatures depent on hpperc.
    Author: 			Ascer - example
]]

local IGNORE_LIST = {"player1", "player2"} 			-- list of players to ignore with Capital letter.
local RANGE = 7					     				-- max distance to attack creatures
local SHOOT_RUNE = {enabled = false, runeid = 2311}	-- attack with runes: true/false, rune id

-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getCreatureWithSkull(list, range)
--> Description: 	Get table with creature to attack.
--> Class: 			None
--> Params:			
-->					@list table with creature names
-->					@range number max distance between you and creature
--> Return: 		table with monster info or -1 if not found.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCreatureWithSkull(list, range)
	
	-- load target id
	local target = Self.TargetID()

	-- check if we have target.
	if target > 0 then

		-- read creatures
	    local creatures = Creature.iCreatures(7, false) 

	    -- in loop for creatures.
	    for i = 1, #creatures do

	    	-- load single creature.
	    	local creature = creatures[i]

	    	-- check if id of our creature is this same as our target id.
	    	if target == creature.id then

	    		-- return info with our target.
	    		return creature

	    	end	

	    end	

	-- we don't have target.		
	else	

		-- read creatures
	    local creatures = Creature.iCreatures(range, false) 

	    -- in loop for creatures.
	    for i = 1, #creatures do

	    	-- load single creature.
	    	local creature = creatures[i]

	    	-- check if valid name
	    	if not table.find(list, creature.name) and (creature.skull == SKULL_WHITE or creature.skull == SKULL_RED)  then

	    		-- we found creature return.
	    		return creature

	    	end
	    	
	    end

	end 

	-- return -1 don't found.
	return -1   		

end


-- module to run function
Module.New("Attack Skulls", function (mod)

	-- when we are connected
	if Self.isConnected() then
        
		-- load current creature.
		local creature = getCreatureWithSkull(IGNORE_LIST, RANGE)

		-- when creature is different than -1
		if creature ~= -1 then

			-- if we have target id.
			if Self.TargetID() > 0 then

				-- check if creature is not too far
				if Creature.DistanceFromSelf(creature) > RANGE then

					-- stop attack
					Self.Stop()

				else
				
					-- when shooting runes is enabled use rune
					if SHOOT_RUNE.enabled and Creature.isPlayer(creature) then

						-- use rune
						Self.UseItemWithCreature(creature, SHOOT_RUNE.runeid, 1000)

					end	

				end
			
			-- we don't have target	
			else

				-- attack creature.
				Creature.Attack(creature.id)

				-- wait some time.
				wait(200, 500)

			end
			
		end

	end

	-- module execution delay.
	mod:Delay(200, 500)	

end)
