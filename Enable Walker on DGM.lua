--[[
    Script Name: 		Enable Walker on DGM
    Description: 		If you receive dmg form any kind of player/monster bot will enable walker.
    Author: 			Ascer - example
]]

local KEY_WORDS = {"You lose"}              -- set keyword for activate
local FRIENDS = {"Friend1", "Friend2"}      -- friend list to avoid, name with capital letters.


-- DON'T EDIT BELOW THIS LINE


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getProxy(keywords, friends)
--> Description:    Search in error message proxy specific keyword.
--> Class:          None
--> Params:         
-->                 @keywords table of strings we search.
-->                 @friends table if our friends to avoid if we skill example.
--> Return:         string last proxy message if keyword found or empty string ""
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getProxy(keywords, friends)

    -- load last proxy msg
    local proxy = Proxy.ErrorGetLastMessage()

    -- in loop for key words
    for i = 1, #keywords do

        -- load single key
        local key = keywords[i]

        -- check if string is inside proxy
        if string.instr(proxy, key) then

            -- in loop check if string not contains our friends.
            for j = 1, #friends do

                -- load single friend.
                local friend = friends[j]

                -- check if attacking our friend.
                if string.instr(proxy, "attack by " .. friend) then

                    -- return empty string
                    return ""

                end    

            end

            -- return proxy.
            return proxy

        end
        
    end
    
    -- return empty string ""
    return ""        

end


-- module to run function in loop 200ms
Module.New("Enable Walker on DGM", function ()

	-- load if we found proxy key
    local proxy = getProxy(KEY_WORDS, FRIENDS)

    -- when proxy is diff than ""
    if proxy ~= "" then

    	-- when walker is disabled enable walker.
    	if not Walker.isEnabled() then 

    		-- enable walker
    		Walker.Enabled(true)

    	else	

    		-- reset proxy message.
    		Proxy.ErrorClearMessage()

    	end	

    end	

end)
