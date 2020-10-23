--[[
    Script Name: 		Stop Bot on Mana
    Description: 		Stop bot when your mana is above and enable when below.
    Author: 			Ascer - example
]]

local MANA = 120  -- when mana points below then enable bot else disable


-- DONT'T EDIT BELOW THIS LINE 

Module.New("Stop Bot on Mana", function ()
	
    -- when mana is above config
    if Self.Mana() >= MANA then
        
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
