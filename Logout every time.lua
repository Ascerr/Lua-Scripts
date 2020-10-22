--[[
    Script Name:        Logout every time
    Description:        Take logout action every some time.
    Author:             Ascer - example
]]

local LOGOUT_EVERY = 15   -- minutes every logged you out.


-- DONT EDIT BELOW THIS LINE

local logoutTime = os.time()

Module.New("Logout every time", function (mod)

    -- when time is ok logout char
    if os.time() - logoutTime >= (60 * LOGOUT_EVERY) then

        -- logout.
        Self.Logout()

        -- update time
        logoutTime = os.time()

    end    


    -- module execution delay in ms.
    mod:Delay(500, 1500)

end)
