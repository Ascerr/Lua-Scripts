--[[
    Script Name:        Bed Regeneration
    Description:        Relogin to game every some time for a couple of seconds for make runes and use bed (sleep)
    Author:             Ascer - example
]]

local BED_SLEEP_TIME = 90.0          -- mintues we are stay offline in bed.

local STAY_LOGGED_SECONDS = 15     -- amount of seconts we stay logged before use bed.

local BED_POS = {33074, 32815, 7}  -- position of bed in house.

local BED_ID = 2489                -- ID of bed

-- DONT'T EDIT BELOW THIS LINE

local mainTime, firstTime, logout = 0, true, false

-- mod to run functions
Module.New("Bed Regeneration", function (mod)
    
    -- check if we should login.
    if firstTime or ((os.clock() - mainTime) >= (BED_SLEEP_TIME * 60)) then
        
        -- if we are connected to game.
        if Self.isConnected() then
            
            if not logout then

                -- wait 15s 
                wait(STAY_LOGGED_SECONDS * 1000)

                -- set logout true
                logout = true 

            else
            
                -- use house bed
                Map.UseItem(BED_POS[1], BED_POS[2], BED_POS[3], BED_ID, 0)

                -- disable firstTime
                firstTime = false

            end  

        else
             
            if logout then

                -- set time to wait before we login again   
                mainTime = os.clock()
                
            end

            -- reconnect to game
            Rifbot.PressKey(13, 2000)  -- press enter key

            logout = false

        end 
                 
    end     

    mod:Delay(200, 350)

end) 
