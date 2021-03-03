--[[
    Script Name:        Imitate Player While Caveboting
    Description:        Players can easy mark you as bot when you walking on follow and don't do anything else. Lets try to be more human. 
    Author:             Ascer - example
]]

--> Modules delay execute every random ms
local MOD_STEP = {900, 1300}			-- execute step near target every this time
local MOD_TURN = {600, 1100}			-- execute turn to target every this time
local MOD_DANCE = {6000, 8000}			-- execute dance every this time
local MOD_PUSH = {3000, 5000, true}		-- execute push items every this time in miliseconds, enabled true/false
local MOD_DRAG = {7000, 10000, true}		-- execut drag item while moving without target, enabled true/false

local STEP_DIAGONAL = true 				-- allow step diagonal near target.
local STEP_DELAY = 500					-- step every x ms to avoid overdash.
local ALLOW_WALK_IDS = {123}			-- enter here id such as parcels, boxes etc we check for it.

-- DON'T EDIT BELOW THIS LINE
local stepTime, modStepTime, modStepRand, modTurnTime, modTurnRand, modDanceTime, modDanceRand, modDancePosTime, modDancePos, modPushTime, modPushRand, modDragTime, modDragRand, modDragTries, modDragMaxTries = 0, 0, 0, 0, 0, 0, 0, 0, {0, 0, 0}, 0, 0, 0, 0, 0, 7

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		tileIsWalkable(x, y, z)
--> Description: 	Check is tile is walkable // Medivia only	
--> Params:			
-->					@x coordinate in the map on the x-axis
-->					@y coordinate in the map on the y-axis
-->					@z coordinate in the map on the z-axis
-->					@player bool (optional default true) read player as not walkable true false 
-->
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function tileIsWalkable(x, y, z, player)
	local path = 0
	local items = Map.GetItems(x, y, z)
	for i, item in ipairs(items) do
		if (player == nil or player == true) and item.id == 99 then return false end
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
--> Description: 	Get creature you already attack	
--> Params:			
-->
-->					@dir number direction to step
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function delayedStep(dir)
	if os.clock() - stepTime > (STEP_DELAY / 1000) then
		Self.Step(dir)
		stepTime = os.clock()
		return true
	end
	return false	
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getDirToStepNearTarget(c)
--> Description: 	Get possible steps dir near target.
--> Params:			
-->
-->					@c table with creature
--> Return: 		table dirs
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getDirToStepNearTarget(c)
	local s = Self.Position()
	local dir = {-1 ,-1}
	if c.x == (s.x + 1) and c.y == (s.y + 1) then
		dir = {1, 2}
	elseif c.x == (s.x) and c.y == (s.y + 1) then
		dir = {3, 1, 6, 5}
	elseif c.x == (s.x - 1) and c.y == (s.y + 1) then
		dir = {3, 2}
	elseif c.x == (s.x - 1) and c.y == (s.y) then
		dir = {0, 2, 7, 6}
	elseif c.x == (s.x - 1) and c.y == (s.y - 1) then
		dir = {0, 3}	
	elseif c.x == (s.x) and c.y == (s.y - 1) then
		dir = {3, 1, 7, 4}
	elseif c.x == (s.x + 1) and c.y == (s.y - 1) then
		dir = {0, 1}
	elseif c.x == (s.x + 1) and c.y == (s.y) then
		dir = {0, 2, 4, 5}
	end
	return dir	
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

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getPushPositionFromDir
--> Description: 	Get push item direction from current self position
--> Params:			None			
-->
--> Return: 		table pos
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPushPositionFromDir()
	local dir = Self.Direction()
	local s = Self.Position()
	local pos = {-1, -1, -1}
	if dir == 0 then
		pos = {s.x, s.y - 1, s.z}
	elseif dir == 1 then
		pos = {s.x + 1, s.y, s.z}
	elseif dir == 2 then
		pos = {s.x, s.y + 1, s.z}
	elseif dir == 3 then
		pos = {s.x - 1, s.y, s.z}
	end			
	return pos
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		updateSelfPosition()
--> Description: 	Update character position and measure time we dont moving.
--> Params:			None
-->
--> Return: 		void nothing.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function updateSelfPosition()
	local pos = Self.Position()
	if modDancePos[1] ~= pos.x or modDancePos[2] ~= pos.y or modDancePos[3] ~= pos.z then
		modDancePos[1] = pos.x
		modDancePos[2] = pos.y
		modDancePos[3] = pos.z
		modDancePosTime = os.clock()
	end	
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		modStep(c)
--> Description: 	Step near target
--> Params:			
-->
-->					@c table with creature
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function modStep(c)
	if Creature.DistanceFromSelf(c) == 1 and not Looter.isLooting() and not Self.isDancing() and not Self.isItemFunPlaying() then
		if os.clock() - modStepTime > (modStepRand / 1000) then
			local turnDir = getTurnDirToTarget(c)
			if turnDir ~= -1 and Self.Direction() == turnDir then
				local dirs = getDirToStepNearTarget(c)
				if dirs[1] ~= -1 then
					local pos1 = Self.getPositionFromDirection(dirs[1])
					local pos2 = Self.getPositionFromDirection(dirs[2])
					local dir = {}
					if tileIsWalkable(pos1.x, pos1.y, pos1.z) then
						table.insert(dir, dirs[1])
					end	
					if tileIsWalkable(pos2.x, pos2.y, pos2.z) then
						table.insert(dir, dirs[2])
					end
					if STEP_DIAGONAL then
						if table.count(dirs) == 4 then
							local pos3 = Self.getPositionFromDirection(dirs[3])
							local pos4 = Self.getPositionFromDirection(dirs[4])
							if tileIsWalkable(pos3.x, pos3.y, pos3.z) then
								table.insert(dir, dirs[3])
							end	
							if tileIsWalkable(pos4.x, pos4.y, pos4.z) then
								table.insert(dir, dirs[4])
							end	
						end
					end		
					if table.count(dir)	> 0 then
						dir = dir[math.random(1, table.count(dir))]
						if delayedStep(dir) then
							modStepTime = os.clock()
							modStepRand = math.random(MOD_STEP[1], MOD_STEP[2])
							if dir > 3 then 
								modStepRand = modStepRand + 1500
							end	
						end	
					end	
				end	
			end	
		end	
	end
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		modTurn(c)
--> Description: 	Turn into target direction
--> Params:			
-->
-->					@c table with creature
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function modTurn(c)
	if Creature.DistanceFromSelf(c) == 1 and not Self.isDancing() and not Self.isItemFunPlaying() then
		if os.clock() - modTurnTime > (modTurnRand / 1000) then
			local dir = getTurnDirToTarget(c)
			if dir ~= -1 then
				Self.Turn(dir)
				modTurnTime = os.clock()
				modTurnRand = math.random(MOD_TURN[1], MOD_TURN[2])	
			end	
		end	
	end
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		modDance()
--> Description: 	Dance like a pro.
--> Params:			None
-->
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function modDance(c)
	if Creature.DistanceFromSelf(c) == 1 and os.clock() - modDanceTime > (modDanceRand / 1000) and os.clock() - modDancePosTime > 1.5 then
		if not Self.isWalking() then
			Self.Dance()
			modDanceTime = os.clock()
			modDanceRand = math.random(MOD_DANCE[1], MOD_DANCE[2])	
		end	
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		modPush(c)
--> Description: 	Push items like a crazy.
--> Params:			@c table with creature
-->
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function modPush(c)
	if MOD_PUSH[3] then
		if Creature.DistanceFromSelf(c) == 1 and os.clock() - modPushTime > (modPushRand / 1000) and not Looter.isLooting() and not Self.isDancing() and os.clock() - modDancePosTime > 1.5 then
			if not Self.isWalking() then
				Self.ItemFunPlay()
				modPushTime = os.clock()
				modPushRand = math.random(MOD_DANCE[1], MOD_DANCE[2])	
			end	
		end
	end		
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		modDrag()
--> Description: 	Drag items when walking.
--> Params:			None
-->
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function modDrag()
	if MOD_DRAG[3] then
		if os.clock() - modDragTime > (modDragRand / 1000) and Self.isWalking() and not Looter.isLooting() and not Self.isDancing() then
			local dir = Self.Direction()
			local pos = Self.Position()
			local map = Map.GetTopMoveItem(pos.x, pos.y, pos.z)
			if not Item.hasAttribute(map.id, ITEM_FLAG_NOT_MOVEABLE) and map.id ~= 99 then
				local dest = getPushPositionFromDir()
				if tileIsWalkable(dest[1], dest[2], dest[3], false) then 
					Map.MoveItem(pos.x, pos.y, pos.z, dest[1], dest[2], dest[3], map.id, map.count, math.random(150, 250))
				end
				modDragTries = modDragTries + 1	
				
			end
			if modDragTries > modDragMaxTries then
				modDragTime = os.clock()
				modDragRand = math.random(MOD_DRAG[1], MOD_DRAG[2])
				modDragMaxTries = math.random(13, 17)
				modDragTries = 0
			end		
		end
	end				
end	


-- module run function in loop 200ms
Module.New("Imitate Player While Caveboting", function()
	if Self.isConnected() then
		updateSelfPosition()
		local t = getAttackedCreature()
		if t ~= -1 then
			modStep(t)
			modTurn(t)
			modDance(t)
			modPush(t)
		else		
			modDrag()
		end	
	end	
end)
