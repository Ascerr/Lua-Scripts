--[[
    Script Name:        Walk though players in protection zone 
    Description:        Enable/disable walk though players depend if protection zone or not. This won't works on servers which don't show isProtectioZone flag.
    Author:             Ascer - example
]]

local FLAG = FLAG_ISINPZ -- flag number default 16384


-- DON'T EDIT BELOW THIS LINE

Module.New("Walk though players in protection zone", function ()
    if Self.isConnected() then
        local data = 0
        if selfIsFlag(FLAG_ISINPZ) then
            data = 1
        end
        Walker.SettingsChange("Walk Through Players", data)    
    end 
end)