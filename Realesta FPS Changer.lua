--[[
    Script Name: 		Realesta FPS Changer.
    Description: 		Change fps ingame to lower only on Realesta Server.
    Author: 			Ascer - example
]]

local FPS = 333333 -- value to set into memory. while 333333 is 3 fps, 1000000 is 1 fps and 100000 is 10 fps  
local FPS_ADDRESS = 0x43D608 -- memory address with fps value to set (edit only when game update if you've knowladge)

-- DON'T EDIT BELOW THIS LINE

local addrBase = Rifbot.getClientInfo().base

Module.New("Realesta FPS Changer", function()
    if Rifbot.MemoryRead(addrBase + FPS_ADDRESS) ~= FPS then
        Rifbot.MemoryWrite(addrBase + FPS_ADDRESS, FPS)
    end    
    mod:Delay(2000)
end)
