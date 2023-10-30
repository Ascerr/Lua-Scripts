--[[
    Script Name:        Bed Regeneration
    Description:        Relogin to game every some time for a couple of seconds for make runes and use bed (sleep)
    Author:             Ascer - example
]]

local BED_SLEEP_TIME = 90.0          -- mintues we are stay offline in bed.
local STAY_LOGGED_SECONDS = 15     -- amount of seconts we stay logged before use bed.
local BED_POS = {32348, 32218, 5}  -- position of bed in house.
local BED_ID = 2489                -- ID of bed

-- DONT'T EDIT BELOW THIS LINE

local stayTime, sleepTime = 0, 0

Module.New("Bed Regeneration", function (mod)
    if Self.isConnected() then
        if stayTime == 0 then
            stayTime = os.clock()
            sleepTime = 0
        else
            if os.clock() - stayTime >= STAY_LOGGED_SECONDS then
                Map.UseItem(BED_POS[1], BED_POS[2], BED_POS[3], BED_ID, 0)
                sleepTime = os.clock()
            end    
        end    
    else
        stayTime = 0
        if os.clock() - sleepTime > (BED_SLEEP_TIME * 60) then
            Rifbot.PressKey(13, 2000)  -- press enter key
        end    
    end    
    mod:Delay(200, 350)
end) 
