--[[
    Script Name: 		VIP Logout
    Description: 		Logout when specific players are online
    Author: 			Ascer - example
]]

local VIP_LIST = {"enemy1", "enemy2"}    -- enter players here separated with comma
local RELOGIN = {               
    enabled = true,              -- relogin true/false
    delay = 6                   -- relogin after X minutes
}

-- DON'T EDIT BELOW THIS LINE

local stime, reconnect = 0, false

Module.New("VIP Logout", function ()
    if Self.isConnected() then
        if VIP.isOnline(VIP_LIST) then
            Self.Logout()
            stime = os.clock()
            reconnect = true
        end
    else
        if RELOGIN.enabled then
            if reconnect then
                printf("Successfully logout due a VIP online. Relogin for " .. math.floor((RELOGIN.delay * 60) - (os.clock() - stime)) .. "s." )
                wait(800, 1200)
                if os.clock() - stime > (60 * RELOGIN.delay) then
                    Rifbot.PressKey(13)  -- press enter key 
                end
            else
               Rifbot.PressKey(13)
               wait(800, 1200)
            end        
        end
    end                    
end)