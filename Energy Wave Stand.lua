--[[
    Script Name:        Energy Wave Stand
    Description:        Reach best position to shoot wave in blocker with monsters
    Author:             Ascer - example
]]

local BLOCKER = "Player nick"	 -- nick of blocker.
local ALLOW_WALK_IDS = {123, 2118, 2119, 2123, 2125, 2124}	-- enter here id such as parcels, boxes, fields etc we check for it.
local DISTANCE = 3				-- distance between you and bloker

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
--> Function:		getBlocker()
--> Description: 	Get your blocker
--> Params:			None
-->
--> Return: 		-1 if no creature else table with creature
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getAttackedCreature()
	local c = Creature.getCreatures(BLOCKER)
	if table.count(c) < 2 then return -1 end
	return c
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		reachBlocker()
--> Description: 	Get possible best way to reach blocker
--> Params:			None
-->
--> Return: 		-1 if no creature else table with creature
----------------------------------------------------------------------------------------------------------------------------------------------------------
function reachBlocker()
	local t = getAttackedCreature()
	if t ~= -1 then
		
		-- load self pos
		local selfpos = Self.Position()

		-- load positions available positions
		local positions = {{x=t.x-DISTANCE, y=t.y, z=t.z, walkable=false, dir=1}, {x=t.x+DISTANCE, y=t.y, z=t.z, walkable=false, dir=3}, {x=t.x, y=t.y+DISTANCE, z=t.z, walkable=false, dir=0}, {x=t.x, y=t.y-DISTANCE, z=t.z, walkable=false, dir=2}}

		-- check if we are on pos.
		for i, pos in ipairs(positions) do
			if (pos.x == selfpos.x and pos.y == selfpos.y and pos.z == selfpos.z) then
				if Self.Direction() ~= pos.dir then
					Self.Turn(pos.dir)
				end
				return true	
			end	
		end	

		-- check if pos is walkable.
		for i, pos in ipairs(positions) do
			if tileIsWalkable(pos.x, pos.y, pos.z) then
				positions[i].walkable = true
			end	
		end	

		-- set params for calc
		local far, lastpos = 12, -1

		-- get the possible close way:
		for i, pos in ipairs(positions) do
			if pos.walkable then
				local dist = Self.DistanceFromPosition(pos.x, pos.y, pos.z)
				if dist < far then
					far = dist
					lastpos = pos
				end	
			end	
		end	

		-- when no pos.
		if lastpos == -1 then
			local near = {}
			for x = -1, 1 do
				for y = -1, 1 do
					if tileIsWalkable(t.x+x, t.y+y, t.z) then
						table.insert(near, {x=t.x+x, y=t.y+y, z=t.z})
					end	
				end
			end
			for i, pos in ipairs(near) do
				local dist = Self.DistanceFromPosition(pos.x, pos.y, pos.z)
				if dist < far then
					far = dist
					lastpos = pos
				end	
			end		
		end	
		
		-- when no last post after calculation break
		if lastpos == -1 then return false end

		-- walkto pos
		Self.WalkTo(lastpos.x, lastpos.y, lastpos.z)

	end	

end	
	
-- module run function in loop 200ms
Module.New("Energy Wave Stand", function()
	if Self.isConnected() then
		reachBlocker()
	end	
end)
