--[[
    Script Name: 		Capity Alert
    Description: 		Play sound if capity will below x value
    Author: 			Ascer - example
]]

local CAPITY = 100    -- when cap below this value play sound.

-- DON'T EDIT BELOW THIS LINE

Module.New("Capity Alert", function()
    if Self.isConnected() and Self.Capity() <= CAPITY then
        Rifbot.PlaySound("No Capity.mp3")
    end    
    mod:Delay(500, 1000)
end)
