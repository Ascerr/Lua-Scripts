--[[
    Script Name:        Cure Poison
    Description:        Cast exana pox when your character under poison cond.
    Author:             Ascer - example
]]

local config = {
	spell = "exana pox",					-- name of spell to cast
	minHealth = 50,							-- don't cast if self hpperc below.
	ifNoMonsters = false,					-- true/false when monsters don't cast
	cureOnlyIfHighDMG = {					-- use cure spell only when you getting high dmg from poison , 
		enabled = false, 					-- @enabled - true/false
		minDmg = 15, 						-- @minDmg - minimal dmg
		msg = "You lose (.+) hitpoints due to an attack by a scorpion." -- @msg - proxy message we catch for hitpoints: (.+) is place where number will be placed in msg to recignize it. You can also use: "You lose (.+) hitpoints"
	}	
}

-- DON'T EDIT BELOW THIS LINE

local dmg = false

-- main loop
Module.New("Cure Poison", function ()
    if Self.isConnected() then
	    if Self.isPoisioned() then
	    	if Self.HealthPercent() >= config.minHealth then    
	        	local var = (not config.cureOnlyIfHighDMG.enabled or (config.cureOnlyIfHighDMG.enabled and dmg))
	        	if config.ifNoMonsters and table.count(Creature.iMonsters(7, false)) > 0 then return end
	        	if var then
	        		Self.CastSpell(config.spell, 30)
	        	end	
	        end
	    else    	
	    	dmg = false
	    end
	end        
end)

-- read proxy for dmg
if config.cureOnlyIfHighDMG.enabled then
	function proxyText(messages) 
		for i, msg in ipairs(messages) do
			local hit = string.match(msg.message, config.cureOnlyIfHighDMG.msg)
	        if hit ~= nil then
	            hit = tonumber(hit)
	            if hit >= config.cureOnlyIfHighDMG.minDmg then 
	            	print(msg.message)
	            	dmg = true
	            end
	        end   	
		end 
	end 
	Proxy.TextNew("proxyText")
end	
