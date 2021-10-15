--[[
    Script Name: 		Pause Bot on High Dmg
    Description: 		Reading white proxy message about hitpoints loses and pause bot.
    Author: 			Ascer - example
]]

local DMG = 500			-- pause bot when lose 500 or more hitpoints


-- DON'T EDIT BELOW THIS LINE

function proxyText(messages) 
    for i, msg in ipairs(messages) do 
    	local hit = string.match(msg.message, "You lose (.+) hitpoints")
    	if hit ~= nil then
    		hit = tonumber(hit)
    		if hit >= DMG then
    			Rifbot.setEnabled(false)
    			Rifbot.PlaySound("Default.mp3")
    			break
    		end	
    	end 
    end 
end 
Proxy.TextNew("proxyText")