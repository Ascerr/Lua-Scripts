--[[
    Script Name: 		Looter after kill monsters
    Description: 		Loot only when monsters killed already.
    Author: 			Ascer - example
]]

local config = {
	range = 7,										-- search monsters in range (7 deafult full screen)
	disableCavebot = {enabled = false, delay = 5}	-- disable walker and targeting while looting, enabled - true/false, delay - amount seconds to restore
}		


-- DON'T EDIT BELOW THIS LINE

local disableTime, disableCavebot = 0, false

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMonsters()
--> Description: 	Get amount monsters in specific range.
--> Class: 			Self
-->					
--> Return: 		number monsters amount.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters()

	-- set default count and load target
	local count, target = 0, Self.TargetID()

	-- inside loop for all found creatures do:
	for i, mob in pairs(Creature.iMonsters(config.range, false)) do

		-- increate count
		count = count + 1

		-- when monsters is target add to looting.
		if mob.id == target then Looter.AddCreature(mob) end
		
	end

	-- return monsters amount.
	return count

end	

-- mod to run function in loop 200ms
Module.New("Looter after kill monsters", function ()
	if Self.isConnected() then
		if disableCavebot and os.clock() - disableTime > config.disableCavebot.delay then
			local w, t = Walker.isEnabled(), Targeting.isEnabled()
			if not w or not t then
				if not w then Walker.Enabled(true) end
				if not t then Targeting.Enabled(true) end
			else	
				disableCavebot = false
			end	
		end	
		local monsters = getMonsters()
		if monsters <= 0 then
			if not Looter.isEnabled() then 
				Looter.Enabled(true) 
				if config.disableCavebot.enabled then
					Walker.Enabled(false)
					Targeting.Enabled(false)
					disableTime = os.clock()
					disableCavebot = true
				end	
			end
		else	
			if not Looter.isLooting() then
				if Looter.isEnabled() then 
					Looter.Enabled(false)
				end
			end	
		end		
	end	
end)
