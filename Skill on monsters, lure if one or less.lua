--[[
    Script Name: 		Skill on monsters, lure if one or less
    Description: 		If low monsters near you then set targeting if stuck and enable walker to lure more then back to training spot.
    Required:			Stand on spot, set attack mode: none, enable targeting, load lua script.

    cavebot nodes like this:
 

 	skill
 	stand: 32371, 32182, 8	--> skill stand where we stay
 	wait: 1000
 	node: 32371, 32182, 8	--> nodes on cave to walk for monsters
 	node: 32371, 32182, 8
 	node: 32371, 32182, 8
 	node: 32371, 32182, 8
 	node: 32371, 32182, 8
 	node: 32371, 32182, 8
	
    Author: 			Ascer - example
]]

local config = {
	pos = {x = 32371, y = 32182, z = 8},						-- default skill position, back here when monsters appear on screen
	monsters = {"rotworm", "troll", "rat", "cave rat"},			-- accept only this name
	range = 7,													-- enable walker only if no monsters on screen.
	label = "skill",											-- label to go when we found good amount of monsters
	luringWalkTime = 1000										-- walk every this miliseconds 
}

-- DONT EDIT BELOW THIS LINE
local isLuring, switchLabel = false, false
config.monsters = table.lower(config.monsters)

Walker.SettingsChange("Lure Step Time", config.luringWalkTime) 					-- set delay for walking while luring

function getMonstersAround(range)
	local count = 0
	for _, c in ipairs(Creature.iMonsters(range, false)) do
		if table.find(config.monsters, string.lower(c.name)) then
			if Creature.DistanceFromSelf(c) <= range then
				count = count + 1
			end	
		end	
	end
	return count	
end	--> return amount of monsters in range

Module.New("Skill on monsters, lure if one or less", function ()
    if Self.isConnected() then
    	if not isLuring then
    		if getMonstersAround(config.range) < 2 then
				if not Walker.isEnabled() then
					Walker.Enabled(true)		--> enable walker, luring mode, targeting if stuck
					Walker.setLureMode(true)
					Targeting.Enabled(false)
				else
					isLuring = true
				end	
			end
		else	
    		if not switchLabel then
    			if getMonstersAround(6) >= 2 then --> search monsters in range 6 sqm to stop following nodes
	  				Walker.Goto(config.label)
	    			switchLabel = true
	    		end
	    	else	
	    		--> here character walking to label skill and under label will be stand to skill position
	    		if Self.DistanceFromPosition(config.pos.x, config.pos.y, config.pos.z) <= 0 then
	    			if Walker.isEnabled() then 
	    				Walker.setLureMode(false)
	    				Walker.Enabled(false)
	    				Targeting.Enabled(true)
	    			else	
	    				switchLabel = false
	    				isLuring = false
	    			end	
	    		end	
	    	end		
    	end	
    end	
end)    	
        
