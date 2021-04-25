--[[
    Script Name:        Turn To Target
    Description:        Step and turn face to target for exori vis shooting example. [Works for servers with implemented cavebot]
    Author:             Ascer - example
]]

local STEP_DELAY = 700					-- step every x ms to avoid overdash.
local ALLOW_WALK_IDS = {123}			-- enter here id such as parcels, boxes etc we check for it.
local MONSTERS = {"rat", "cave rat", "cyclops", "rotworm", "troll"}	-- monsters to active
local SPELL = {
	name = "exori vis", 				-- spell to cast
	mana = 20, 							-- min mana to cast spell
	selfSafeHpPerc = 50					-- don't cast if hpperc below this %
}

-- DON'T EDIT BELOW THIS LINE
local stepTime = 0

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
	if c.hpperc <= 0 then return - 1 end
	return c
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		shootSpell()
--> Description: 	Shoot spell in free spot area, depent on mana and hpperc. Cast every 1000ms	
--> Params:			None
-->
--> Return: 		nil
----------------------------------------------------------------------------------------------------------------------------------------------------------
function shootSpell()
	local mp, hp = Self.Mana(), Self.HealthPercent()
	if Self.HealthPercent() > SPELL.selfSafeHpPerc then
		if Self.Mana() > SPELL.mana then
			Self.CastSpell(SPELL.name, SPELL.mana, 1000)
		end	
	end	
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

-- module run function in loop 200ms
Module.New("Turn To Target", function()
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
					end
				elseif t.x == s.x and t.y == (s.y - 1) then
					if Self.Direction() ~= 0 then Self.Turn(0) else shootSpell() end
				elseif t.x == (s.x + 1) and t.y == (s.y - 1) then
					if tileIsWalkable(s.x, s.y - 1, s.z) then 
						delayedStep(0)
					elseif tileIsWalkable(s.x + 1, s.y, s.z) then
						delayedStep(1)
					end
				elseif t.x == (s.x + 1) and t.y == s.y then
					if Self.Direction() ~= 1 then Self.Turn(1) else shootSpell() end
				elseif t.x == (s.x + 1) and t.y == (s.y + 1) then
					if tileIsWalkable(s.x, s.y + 1, s.z) then 
						delayedStep(2)
					elseif tileIsWalkable(s.x + 1, s.y, s.z) then
						delayedStep(1)
					end
				elseif t.x == s.x and t.y == (s.y + 1) then
					if Self.Direction() ~= 2 then Self.Turn(2) else shootSpell() end
				elseif t.x == (s.x - 1) and t.y == (s.y + 1) then
					if tileIsWalkable(s.x, s.y + 1, s.z) then 
						delayedStep(2)
					elseif tileIsWalkable(s.x - 1, s.y, s.z) then
						delayedStep(3)
					end
				elseif t.x == (s.x - 1) and t.y == s.y then
					if Self.Direction() ~= 3 then Self.Turn(3) else shootSpell() end
				end	
			end	
		end	
	end	
end)