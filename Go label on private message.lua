--[[
    Script Name:        Go label on private message
    Description:        If your character receive message from other player "refill" then will go to label "back"
    Author:             Ascer - example
]]
 
local config = {
    signal = "refill",                          -- signal to make action 
    senders = {"nick1", "nick2"},               -- characters names we accept signal
    label = "back"                              -- where to go label name.
}

-- DONT EDIT BELOW THIS LINE 

config.senders = table.lower(config.senders)

function proxy(messages) 
    for i, msg in ipairs(messages) do 
        if table.find(config.senders, string.lower(msg.speaker)) then 
            if string.lower(msg.message) == string.lower(config.signal) then
                Walker.Goto(config.label)     
            end
        end        
    end 
end 
Proxy.New("proxy")