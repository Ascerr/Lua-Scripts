--[[
    Script Name: 		Alert When Teleported
    Description: 		Play sound your character will teleported
    Author: 			Ascer - example
]]

local SQMS = 3          	-- how many sqms diff poss to play sound
local STOP_BOT = false		-- stop bot or not when teleported

-- DON'T EDIT BELOW THIS LINE

local teleported, old = false, {x=0, y=0, z=0}

-- MODULE
Module.New("Alert When Teleported", function()
    if Self.isConnected then
        if teleported then
            Rifbot.PlaySound("Default.mp3")
            if STOP_BOT then
            	if Rifbot.isEnabled() then
            		Rifbot.setEnabled(false)
            	end	
            end	
        end    
        local dist = Self.DistanceFromPosition(old.x, old.y, old.z)
        if dist >= SQMS and old.x ~= 0 then
            teleported = true
        end
        old = Self.Position()
    end    
end)