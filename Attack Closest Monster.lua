--[[
    Script Name: 		Attack Closest Monster
    Description: 		If you targting some creature try always attack this near you.
    Author: 			Ascer - example
]]

local config = {
	range = 3,			-- serarch for monsters only in this range (important! this script don't check for creature reachability so keep mind that with higher range it my attack monsters behind wall)
	only_specific_monsters = {enaled = false, names = {"rat", "cave rat", "spider"}}
}

-- DONT'T EDIT BELOW THIS LINE 
config.only_specific_monsters.names = table.lower(config.only_specific_monsters.names)


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getCreature()
--> Description: 	Check for creatures on screen.
--> Params:			None
-->				
--> Return: 		table creature or 0 if no creature to switch target found.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCreature()

	-- set vars.
	local lastTarget, lastDist, lastTargetDist, var = -1, 10, -1, true

	-- set variable for target
	local target = Self.TargetID()

	-- read creatures on screen
	local creatures = Creature.iMonsters(7, false) 

	-- load self pos
	local selfpos = Self.Position() 

	-- for found creatures in loop
	for i = 1, #creatures do
	    
		-- load single creature
	    local c = creatures[i]

	    local rangeX, rangeY = math.abs(c.x - selfpos.x), math.abs(c.y - selfpos.y)

	    -- when creature is on screen and is diff than curr target.
	    if rangeX <= 7 and rangeY <= 5 then	
	    	
	    	-- set dist.
	    	local dist = rangeX

	    	-- when rangeY is above rangeX set dist
	    	if rangeY > rangeX then dist = rangeY end

	    	-- when creature is already targeted store it range
	    	if target == c.id then lastTargetDist = dist end

	    	-- when we checking for monsters names and not table find then set var on false
	    	if config.only_specific_monsters.enaled and not table.find(config.only_specific_monsters.names, string.lower(c.name)) then var = false end

	    	-- when distance is below range
	    	if dist < lastDist and dist <= config.range and var then 
				
	    		-- save last target
	    		lastTarget = c

	    		-- save distance
	    		lastDist = dist 

	    	end	
		    	
		end
		
	end

	-- when have target and is on this same distance as potential new monster ignore switching target
	if target > 0 and lastTargetDist <= lastDist then return -1 end

	-- return last calculated target
	return lastTarget

end	


Module.New("Attack Closest Monster", function ()
	
	-- Load target.
	local t = getCreature()

	-- when t is diff than -1
	if t ~= -1 then

		-- attack.
		Creature.Attack(t.id)

		wait(500)

	end

end)


