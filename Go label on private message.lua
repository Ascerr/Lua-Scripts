--[[
    Script Name:        Go label on private message
    Description:        If your character receive message from other player "refill" then will go to label "back"
    Author:             Ascer - example
]]
 
local config = {
    signals = {                             
        {signal = "refill", label = "back"},        -- signal table = {signal -> this you sent from main char, label -> receiver go to this label if signal.}
        -- your next here
        {signal = "stop", label = "wait for me"},
    },
    senders = {"nick1", "nick2"},                   -- characters names we accept signal

}

-- DONT EDIT BELOW THIS LINE 

config.senders = table.lower(config.senders)

function proxy(messages) 
    for i, msg in ipairs(messages) do 
        if table.find(config.senders, string.lower(msg.speaker)) then 
            for j, sig in ipairs(config.signals) do
                if string.lower(msg.message) == string.lower(sig.signal) then
                    Walker.Goto(sig.label)     
                end
            end    
        end        
    end 
end 
Proxy.New("proxy")
