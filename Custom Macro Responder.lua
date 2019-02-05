--[[
    Script Name: 		Custom Macro Responder
    Description: 		Respond flashing letters on screen. Required Rifbot v1.31
    Author: 			Ascer - example
]]

local RESPOND_DELAY = {20, 90}              -- random respond time between 20sec and 90sec
local PAUSE_BOT = true                      -- true/false pause afk functions when you are under macro test  

-- DON'T EDIT BELOW THIS LINE

local respondTime, respondDelay = 0, 0

Module.New("Custom Macro Responder", function ()
    local code = Rifbot.getMacroCode()
    printf(code)
    if not Self.isConnected() and respondTime ~= 0 then 
        respondTime = 0 -- reset timer on self.logout
    end    
    if code ~= "" then
        if respondTime == 0 then -- set new delay
            respondTime = os.clock()
            respondDelay = math.random(RESPOND_DELAY[1], RESPOND_DELAY[2])
            if PAUSE_BOT then    
                Rifbot.setMacroMode(true) -- enable macro mode
            end    
        else
            if os.clock() - respondTime >= respondDelay then
                Self.Say(code) -- say code and enable bot
                wait(2000, 5000)
                respondTime = 0
                Rifbot.setMacroMode(false)       
            end
        end
    end            
end)