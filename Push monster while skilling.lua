--[[
    Script Name:        Push monster while skilling
    Description:        If you skilling and monster come from the east, you push him to north and attack.
    Author:             Ascer - example
]]

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		isMonstersOnPos(x, y, z)
--> Description: 	Check if monster is on position x, y, z
--> Params:			
-->					@x coordinate in the map on the x-axis
-->					@y coordinate in the map on the y-axis
-->					@z coordinate in the map on the z-axis
--> Return: 		false or table with monster similar to Creature.getCreatures(special).
----------------------------------------------------------------------------------------------------------------------------------------------------------
function isMonstersOnPos(x, y, z)
	for i, c in ipairs(Creature.iMonsters(1, false)) do
		if c.x == x and c.y == y and c.z == z then
			return c
		end	
	end
	return false	
end	

-- module loop.
Module.New("Push monster while skilling", function(mod)

	-- when connected to game
    if Self.isConnected() then

    	-- load self pos and map.
    	local pos = Self.Position()

    	-- Check if monster is to the north.
    	local northMonster = isMonstersOnPos(pos.x, pos.y-1, pos.z)
    	
    	-- is to the north
    	if table.count(northMonster) > 1 then

    		-- load self target.
    		local target = Self.TargetID()

    		-- when target id is different than monster on north attack.
    		if target ~= northMonster.id then

    			-- attack north monster
    			Creature.Attack(northMonster.id)

    		end

    	-- no monster to the north	
    	else		

    		-- check if monster on east
    		local eastMonster = isMonstersOnPos(pos.x - 1, pos.y, pos.z)

    		-- when is monster.
    		if table.count(eastMonster) > 1 then

    			-- load top item on east monster sqm.
    			local map = Map.GetTopMoveItem(pos.x - 1, pos.y, pos.z)

    			-- move item from east to north with delay 1000 ms (1s) to be able push monster
    			Map.MoveItem(pos.x - 1, pos.y, pos.z, pos.x, pos.y-1, pos.z, map.id, map.count, 1000)

    		end	

    	end	

    end

    -- delay between actions
    mod:Delay(300, 500)	

end)