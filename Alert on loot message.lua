--[[
    Script Name:        Alert on loot message
    Description:        Play sound when specific text appear in message.                
    Author:             Ascer - example 
]]

local ITEMS = {"gold", "Dawn Light"}    -- type here example items from loot message or other text you want to catch.

-- DONT'T EDIT BELOW THIS LINE 

ITEMS = table.lower(ITEMS)

function proxy(messages) 
    for i, msg in ipairs(messages) do 
        for j, item in ipairs(ITEMS) do
            msg.message = string.lower(msg.message)
            if string.find(msg.message, item) then
                Rifbot.PlaySound()    
                print(msg.message, msg.mode)
                break    
            end
        end             
    end 
end
Proxy.TextNew("proxy")