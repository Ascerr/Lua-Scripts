--[[
    Script Name:        Change target if can face creature
    Description:        Step and turn face to target for exori vis shooting example.
    Author:             Ascer - example
]]

local STEP_DELAY = 500					-- step every x ms to avoid overdash.
local ALLOW_WALK_IDS = {123}			-- enter here id such as parcels, boxes etc we check for it.
local MONSTERS = {"Wild warrior", "valkyrie", "war wolf", "skeleton", "rat"}	-- monsters to active

-- DON'T EDIT BELOW THIS LINE
local stepTime = 0

-- lower case table with monsters names
MONSTERS = table.lower(MONSTERS)
----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		tileIsWalkable(x, y, z)
--> Description: 	Check is tile is walkable	
--> Params:			
-->					@x coordinate in the map on the x-axis
-->					@y coordinate in the map on the y-axis
-->					@z coordinate in the map on the z-axis
-->
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function tileIsWalkable(x, y, z)
	local path = 0
	local items = Map.GetItems(x, y, z)
	for i, item in ipairs(items) do
		if item.id == 99 then return false end
		if Item.hasAttribute(item.id, ITEM_FLAG_NOT_WALKABLE) then return false end
		if Item.hasAttribute(item.id, ITEM_FLAG_NOT_PATHABLE) then
			if table.find(ALLOW_WALK_IDS, item.id) then
				path = path + 1
				if path >= 2 then return false end
			else
				return false	
			end	
		end	
	end
	return true
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getAttackedCreature()
--> Description: 	Get creature you already attack	
--> Params:			None
-->
--> Return: 		-1 if no creature else table with creature
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getAttackedCreature()
	local t = Self.TargetID()
	if t <= 0 then return -1 end
	local c = Creature.getCreatures(t)
	if table.count(c) < 2 then return -1 end
	if c.hpperc <= 0 then return - 1 end
	return c
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		delayedStep(dir)
--> Description: 	Get creature you already attack	
--> Params:			
-->
-->					@dir number direction to step
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function delayedStep(dir)
	if os.clock() - stepTime > (STEP_DELAY / 1000) then
		Self.Step(dir)
		stepTime = os.clock()
	end	
end	

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
	local target = Self.TargetID()
	if target > 0 then
	    local creatures = Creature.iCreatures(range, false) 
	    for i = 1, #creatures do
	    	local creature = creatures[i]
	    	if creature.id ~= target then
	    		return creature
	    	end	
	    end		
	else	
	    local creatures = Creature.iCreatures(range, false) 
	    for i = 1, #creatures do
	    	local creature = creatures[i]
	    	if table.find(list, creature.name) and creature.hpperc > HPPERC then
	    		return creature
	    	end
	    end
	end 
	return -1   		
end

function changeTarget()
	local new = getNewTarget(MONSTERS, 5)
	if table.count(new) > 1 then
		Creature.Attack(new.id)
	else	
		Self.Stop()
	end	
end  --> Attack new creature from list or stop attack current


-- module run function in loop 200ms
Module.New("Change target if can face creature", function()
	local s = Self.Position()
	if Self.isConnected() then
		local t = getAttackedCreature()
		if t ~= -1 then
			if table.find(MONSTERS, string.lower(t.name)) then
				local s = Self.Position()
				if t.x == (s.x - 1) and t.y == (s.y - 1) then -- north west
					if tileIsWalkable(s.x, s.y - 1, s.z) then 
						delayedStep(0)
					elseif tileIsWalkable(s.x - 1, s.y, s.z) then
						delayedStep(3)
					else	
						changeTarget()
					end
				elseif t.x == (s.x + 1) and t.y == (s.y - 1) then
					if tileIsWalkable(s.x, s.y - 1, s.z) then 
						delayedStep(0)
					elseif tileIsWalkable(s.x + 1, s.y, s.z) then
						delayedStep(1)
					else	
						changeTarget()
					end
				elseif t.x == (s.x + 1) and t.y == (s.y + 1) then
					if tileIsWalkable(s.x, s.y + 1, s.z) then 
						delayedStep(2)
					elseif tileIsWalkable(s.x + 1, s.y, s.z) then
						delayedStep(1)
					else	
						changeTarget()
					end
				elseif t.x == (s.x - 1) and t.y == (s.y + 1) then
					if tileIsWalkable(s.x, s.y + 1, s.z) then 
						delayedStep(2)
					elseif tileIsWalkable(s.x - 1, s.y, s.z) then
						delayedStep(3)
					else	
						changeTarget()	
					end
				end	
			end	
		end	
	end	
end)