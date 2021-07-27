--[[
    Script Name:        Avoid Front Wave
    Description:        Step to free dir to avoid front wave from monster. [Works only for Kasteria and Medivia]
    Author:             Ascer - example
]]

local STEP_DELAY = 700										-- step every x ms to avoid overdash.
local ALLOW_WALK_IDS = {123, 2118, 2119, 2123, 2125, 2124}	-- enter here id such as parcels, boxes, fields etc we check for it.
local MONSTERS = {"dragon", "dragon lord"}					-- monsters to active
local TURN_TO_TARGET = true 								-- true/false turn self direction to target

-- DON'T EDIT BELOW THIS LINE
local stepTime, modTurnTime, modTurnRand = 0, 0, 0

-- lower case table with monsters names
MONSTERS = table.lower(MONSTERS)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		tileIsWalkable(x, y, z)
--> Description: 	Check is tile is walkable // Medivia only	
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
	return c
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		delayedStep(dir)
--> Description: 	Step with delay
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
--> Function:		getTurnDirToTarget(c)
--> Description: 	Get possible steps dir near target.
--> Params:			
-->
-->					@c table with creature
--> Return: 		number dir
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getTurnDirToTarget(c)
	local s = Self.Position()
	local dir = -1
	if c.x == (s.x + 1) and c.y == (s.y + 1) then
		dir = 1
	elseif c.x == (s.x) and c.y == (s.y + 1) then
		dir = 2
	elseif c.x == (s.x - 1) and c.y == (s.y + 1) then
		dir = 3
	elseif c.x == (s.x - 1) and c.y == (s.y) then
		dir = 3
	elseif c.x == (s.x - 1) and c.y == (s.y - 1) then
		dir = 0	
	elseif c.x == (s.x) and c.y == (s.y - 1) then
		dir = 0
	elseif c.x == (s.x + 1) and c.y == (s.y - 1) then
		dir = 1
	elseif c.x == (s.x + 1) and c.y == (s.y) then
		dir = 1
	end
	return dir	
end		

-- module run function in loop 200ms
Module.New("Avoid Front Wave", function()
	local s = Self.Position()
	if Self.isConnected() then
		local t = getAttackedCreature()
		if t ~= -1 and not Looter.isLooting() then
			if table.find(MONSTERS, string.lower(t.name)) then
				local s = Self.Position()
				if (t.x == (s.x - 1) or t.x == (s.x + 1)) and t.y == s.y then -- west, east
					if tileIsWalkable(s.x, s.y - 1, s.z) then 
						delayedStep(0)
					elseif tileIsWalkable(s.x, s.y + 1, s.z) then
						delayedStep(2)
					end
				elseif (t.y == (s.y - 1) or t.y == (s.y + 1)) and t.x == s.x then -- north, south	
					if tileIsWalkable(s.x + 1, s.y, s.z) then 
						delayedStep(1)
					elseif tileIsWalkable(s.x - 1, s.y, s.z) then
						delayedStep(3)
					end	
				end
				--> turn to target
				if TURN_TO_TARGET then
					if Creature.DistanceFromSelf(t) == 1 then
						if os.clock() - modTurnTime > (modTurnRand / 1000) then
							local dir = getTurnDirToTarget(t)
							if dir ~= -1 then
								Self.Turn(dir)
								modTurnTime = os.clock()
								modTurnRand = math.random(300, 800)	
							end	
						end	
					end	
				end	
			end	
		end	
	end	
end)
