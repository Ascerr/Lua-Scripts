--[[
    Script Name: 		Runelast when target lost
    Description: 		Shoot rune with last targetID no matter is visible or not when receivied proxy message "Target lost"
    Author: 			Ascer - example
]]

local config = {
	runeid = 3155,					-- id of rune to shoot
	offTargetingForWhile = true,	-- off targeting for while to don't lost stored last attacked monster ID.
	waitBeforeShoot = 1000			-- delay in miliseconds character wait after monster became invisible to shoot rune, 
}

-- DON'T EDIT BELOW THIS LINE

local shootRune, lastTarget, lastCreature = false, -1, -1

Module.New("Runelast when target lost", function()
	if Self.isConnected() then
		if shootRune then
			if table.count(lastCreature) > 2 then
				wait(waitBeforeShoot)
				Self.UseItemWithCreature(lastCreature, config.runeid, 0) --> force shoot rune 0 delay 
			end
			shootRune = false	--> disable shooting after 1 tries
			if config.offTargetingForWhile then
				Targeting.Enabled(true)
			end
		end	
		local t = Self.TargetID()
		if t > 0 then
			if t ~= lastTarget then
				lastTarget = t
				lastCreature = Creature.getCreatures(lastTarget)
			end	
		end
	end		
end) --> Module to read last target id


function proxyText(messages) 
	for i, msg in ipairs(messages) do 
		if msg.message == "Target lost." then
			shootRune = true
			if config.offTargetingForWhile then
				Targeting.Enabled(false)
			end	
		end
	end 
end
Proxy.TextNew("proxyText")	--> Proxy func to set shootRune = true on message "Target lost."
