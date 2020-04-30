--[[
    Script Name: 		Stop Bot on Health
    Description: 		Stop bot when your health is below and enable when above value.
    Author: 			Ascer - example
]]

local HEALTH = 30  -- when hp points below then disable bot else enable
local WAIT = 20		-- wait 20 seconds before enable bot again when you health growth.


-- DONT'T EDIT BELOW THIS LINE 

Module.New("Stop Bot on Health", function ()
	
    -- when mana is above config
    if Self.Health() <= HEALTH then
        
        -- if bot is running.
        if Rifbot.isEnabled() then
            
            -- disable bot
            Rifbot.setEnabled(false)
        
        end    

    else

        -- if not is running bot
        if not Rifbot.isEnabled() then
            
	    -- wait time
	    wait(WAIT)
				
            -- enable bot 
            Rifbot.setEnabled(true) 

        end         
    end
    
end)
