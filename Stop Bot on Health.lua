--[[
    Script Name: 		Stop Bot on Health
    Description: 		Stop bot when your health is below and enable when above value.
    Author: 			Ascer - example
]]

local HEALTH = 200  -- when hp points below then disable bot else enable


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
            
            -- enable bot 
            Rifbot.setEnabled(true) 

        end         
    end
    
end)