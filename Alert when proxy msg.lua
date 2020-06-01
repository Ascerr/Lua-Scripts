--[[
    Script Name:        Alert when proxy msg
    Description:        Play sound when white message contains words ..
    Author:             Ascer - example
]]
 
local KEY_WORDS = {"You cannot use"}              -- set keyword for activate
local ALERT_TYPE = 0                              -- type of alert 0 - only once when message received, 1 - continue play sound until script exit.


-- DON'T EDIT BELOW THIS LINE

local continue = false

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getProxy(keywords)
--> Description:    Search in error message proxy specific keyword.
--> Class:          None
--> Params:         
-->                 @keywords table of strings we search.
--> Return:         string last proxy message if keyword found or empty string ""
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getProxy(keywords)

    -- load last proxy msg
    local proxy = Proxy.ErrorGetLastMessage()

    -- when proxy is "" then ret.
    if proxy == "" then return "" end 

    -- in loop for key words
    for i = 1, #keywords do

        -- load single key
        local key = keywords[i]

        -- check if string is inside proxy
        if string.instr(proxy, key) then

            -- return proxy
            return proxy
            
        end
        
    end

    -- return empty string
    return ""

end
    

Module.New("Alert when proxy msg", function ()

    -- check proxy.
    local proxy = getProxy(KEY_WORDS)

    -- when proxy is different then "" or param is true
    if proxy ~= "" or continue then

        -- play sound.
        Rifbot.PlaySound("Default.mp3")

        -- show message in console.
        printf(proxy)

        -- when alert type is 0
        if ALERT_TYPE == 0 then

            -- reset proxy.
            Proxy.ErrorClearMessage()

        else    

            -- set param
            continue = true

        end 

    end 

end)
