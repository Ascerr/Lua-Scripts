--[[
    Script Name:        Logout for while on default message
    Description:        Respond for message on chat
    Author:             Ascer - example
]]

local config = {
    keywords = {"log", "logout"},       -- react only fot this messages on default
    sender = "Character Name",          -- accept message only from this player name (capita)
    relogin_after = 5                   -- relogin to game after 5 seconds
}

-- DON'T EDIT BELOW

config.keywords = table.lower(config.keywords)

local logout, logTime = false, 0

function proxy(messages) 
    for i, msg in ipairs(messages) do 
        if string.lower(msg.speaker) == string.lower(config.sender) then
            if table.find(config.keywords, string.lower(msg.message)) then
                Self.Logout()
                logout = true
            end 
        end     
    end 
end 
Proxy.New("proxy")

Module.New("Logout for while on default message", function()
    if Self.isConnected() then
        if logout then
            Self.Logout()
        end
    else        
        if logout then
            logTime = os.clock()
            logout = false
        else
            if os.clock() - logTime > config.relogin_after then
                Rifbot.PressKey(13, 2000)
            end    
        end
    end    
end)