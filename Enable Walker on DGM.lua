--[[
    Script Name: 		Enable Walker on DGM
    Description: 		If you receive dmg form any kind of player/monster bot will enable walker.
    Author: 			Ascer - example
]]

local KEY_WORDS = {"You lose"}              -- set keyword for activate
local FRIENDS = {"Friend1", "Friend2"}      -- friend list to avoid, name with capital letters.


-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getAttackedByNoFriend(msg)
--> Description:    Check string message for KEY_WORDS and FRIENDS to valid if attack us enemy.
--> Params:         msg - string message from proxy.

--> Return:         boolean true or false   
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getAttackedByNoFriend(msg)
    
    -- in loop for key words
    for i = 1, #KEY_WORDS do

        -- load single key
        local key = KEY_WORDS[i]

        -- check if string is inside proxy
        if string.instr(msg, key) then

            -- in loop check if string not contains our FRIENDS.
            for j = 1, #FRIENDS do

                -- load single friend.
                local friend = FRIENDS[j]

                -- check if attacking our friend.
                if string.instr(msg, "attack by " .. friend) then

                    -- return empty string
                    return false

                end    

            end

            -- return proxy.
            return true

        end
        
    end

    return false

end

-- proxy module to read messages.
function proxy(messages) 
    for i, msg in ipairs(messages) do 
        if getAttackedByNoFriend(msg.message) then
            print(msg.message)
            if not Walker.isEnabled() then 
                Walker.Enabled(true)

            end 
        end    
    end
end 

Proxy.TextNew("proxy")
