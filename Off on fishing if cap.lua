--[[
    Script Name: Off on fishing if cap
    Description: Turn off fishing when cap below x value else turn on.
    Author: Ascer - example
]]

local CAPITY = 40    -- when cap below off fishing

-- DON'T EDIT BELOW THIS LINE

Module.New("Off on fishing if cap", function()
    if Self.isConnected() then 
    	if Self.Capity() >= CAPITY then
        	Rifbot.setCheckboxState("Tools", "AutoFishing", true)
    	else
        	Rifbot.setCheckboxState("Tools", "AutoFishing", false)
        end	    
    end
    mod:Delay(500, 1000)
end)