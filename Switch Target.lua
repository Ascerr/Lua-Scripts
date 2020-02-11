--[[
    Script Name: 		Switch Target
    Description: 		Change target between creatures depent on hpperc.
    Author: 			Ascer - example
]]

local TARGET_LIST = {"mob", "player"} -- list of all possible monsters to switch attack with Capital letter.
local HPPERC = 50 					 -- hpperc, change target when he have less than default 50% hp.
local RANGE = 1					     -- max distance to search creatures.

-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getNewTarget(list, range)
--> Description: 	Get table with creature to attack.
--> Class: 			None
--> Params:			
-->					@list table with creature names
-->					@range number max distance between you and creature
--> Return: 		table with monster info or -1 if not found.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getNewTarget(list, range)
	
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
	    	if table.find(list, creature.name) then

	    		-- we found creature return.
	    		return creature

	    	end
	    	
	    end

	end 

	-- return -1 don't found.
	return -1   		

end


-- module to run function
Module.New("Switch Target", function (mod)

	-- when we are connected
	if Self.isConnected() then
        
		-- load current creature.
		local creature = getNewTarget(TARGET_LIST, RANGE)

		-- when creature is different than -1
		if creature ~= -1 then

			-- check about creature hpperc.
			if creature.hpperc < HPPERC then

				-- zatrzymaj atakowanie.
				Self.Stop()

			-- hp is fine	
			else	

				-- if we have target id.
				if Self.TargetID() > 0 then

					-- check if creature is not too far
					if Creature.DistanceFromSelf(creature) > RANGE then

						-- stop attack
						Self.Stop()

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

	end

	-- module execution delay.
	mod:Delay(200, 500)	

end)
