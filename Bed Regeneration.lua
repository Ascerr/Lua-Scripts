--[[
    Script Name:        Bed Regeneration
    Description:        Relogin to game every some time for a couple of seconds for make runes and use bed (sleep)
    Author:             Ascer - example
]]

local BED_SLEEP_TIME = 0.5          -- mintues we are stay offline in bed.

local STAY_LOGGED_SECONDS = 15     -- amount of seconts we stay logged before use bed.

local BED_POS = {31329, 32431, 7}  -- position of bed in house.

local BED_ID = 2488                -- ID of bed

-- DONT'T EDIT BELOW THIS LINE

local mainTime = 0

-- mod to run functions
Module.New("Bed Regeneration", function (mod)
    
    -- check if we should login.
    if (os.clock() - mainTime) >= (BED_SLEEP_TIME * 60) then
        
        -- if we are connected to game.
        if Self.isConnected() then
            
            -- wait 15s 
            wait(STAY_LOGGED_SECONDS * 1000)

            -- set logout true
            logout = true              

            -- use house bed
            Map.UseItem(BED_POS[1], BED_POS[2], BED_POS[3], BED_ID, 0)

            -- set time to wait before we login again   
            mainTime = os.clock()

        else
                
            -- reconnect to game
            Rifbot.PressKey(13, 2000)  -- press enter key

        end 
                 
    end     

    mod:Delay(200, 350)

end) 
