--[[
    Script Name: 		Attack Monster on Hotkey
    Description: 		Will attack the closest monster.
    					[IMPORTANT] To run it on hotkey type inside Shortkeys: EXECUTE Attack Monster on Hotkey
    Author: 			Ascer - example
]]


-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getCreature()
--> Description: 	Check for creatures on screen.
--> Params:			None
-->				
--> Return: 		boolean true or false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCreature()

	-- set vars.
	local lastTarget, lastDist = -1, 10

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
	    if rangeX <= 7 and rangeY <= 5 and target ~= c.id then	
	    	
	    	-- set dist.
	    	local dist = rangeX

	    	-- when rangeY is above rangeX set dist
	    	if rangeY > rangeX then dist = rangeY end	

	    	-- when distance is below range
	    	if dist < lastDist then 
	    		
	    		-- save last target
	    		lastTarget = c

	    		-- save distance
	    		lastDist = dist 

	    	end	
		    	
		end
		
	end

	-- return last calculated target
	return lastTarget

end	
	

-- SINGLE EXECUTE ON KEY
if Self.isConnected() then

	-- Load target.
	local t = getCreature()

	-- when t is diff than -1
	if t ~= -1 then

		-- attack.
		Creature.Attack(t.id)

	end
		
end
		
