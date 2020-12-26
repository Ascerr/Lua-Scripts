--[[
    Script Name:        Login to game after time
    Description:        If your character is offline longer than e.g. 30 min will login to game.
    Author:             Ascer - example
]]

local LOGIN_AFTER = 30   -- minutes under offline to be able login to game.


-- DONT EDIT BELOW THIS LINE

local logoutTime = 0

Module.New("Login to game after time", function (mod)

    -- when you are online
    if Self.isConnected() then

        -- reset time
        logoutTime = 0

    else 

        -- when logout time is 0 
        if logoutTime == 0 then 

            -- set new timer
            logoutTime = os.time()

        else
            
            -- check if we can login to game.
            if os.time() - logoutTime >= (60 * LOGIN_AFTER) then

                -- login to game standard option sending key enter, for classicTibia use func: classicTibiaRelogin()
                Rifbot.PressKey(13, 3000)

            end

        end        

    end    

    -- module execution delay in ms.
    mod:Delay(500, 1500)

end)
