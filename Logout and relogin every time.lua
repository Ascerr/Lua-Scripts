--[[
    Script Name:        Logout and relogin every time
    Description:        When no pz logout for x minutes then relogin, kill monsters(attack from bot panel)
    Author:             Ascer - example
]]

local TIME_BEEING_LOGGED_OUT = 5        -- minutes under disconnected condition.
local TIME_BEEING_LOGGED = 1            -- minutes we stay online. Minimal time to logout if no pz


-- DONT EDIT BELOW THIS LINE

local logoutTime, stayTime = os.time(), os.time()

Module.New("Logout and relogin every time", function (mod)

    -- when connected.
    if Self.isConnected() then

        -- when no pz
        if not Self.isInFight() and os.time() - stayTime >= (60 * TIME_BEEING_LOGGED) then

            -- logout action
            Self.Logout()

            -- set logout time.
            logoutTime = os.time()

        end 

    else
        
        -- when time is ok login
        if os.time() - logoutTime >= (60 * TIME_BEEING_LOGGED_OUT) then

            -- login to game standard option sending key enter, for classicTibia use func: classicTibiaRelogin()
            Rifbot.PressKey(13, 3000)

            -- update time
            stayTime = os.time()

        end    

    end    

    -- module execution delay in ms.
    mod:Delay(1000, 2500)

end)