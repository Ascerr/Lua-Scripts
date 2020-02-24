--[[
    Script Name: 		Retrocores FPS Changer.
    Description: 		Change fps ingame to lower only on Retrocores Server.
    Author: 			Ascer - example
]]

local FPS = 5 -- amount of fps to set
local FPS_ADDRESS = 0x525FF4 -- memory address with fps value to set (edit only when game update if you've knowladge)

-- DON'T EDIT BELOW THIS LINE

local addrBase = Rifbot.getClientInfo().base

Module.New("Realesta FPS Changer", function()
    if Rifbot.MemoryRead(addrBase + FPS_ADDRESS) ~= FPS then
        Rifbot.MemoryWrite(addrBase + FPS_ADDRESS, FPS)
    end    
    mod:Delay(2000)
end)
