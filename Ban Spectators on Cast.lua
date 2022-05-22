--[[
    Script Name:        Ban Spectators on Cast

    Description:        Auto ban new spectators joined to your cast. 
    Required:			Valid message about joined specator inside line 11.              
    Author:             Ascer - example 
]]

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if string.len(msg.speaker) < 2 then
			local spectator = string.match(msg.message, "(.+) has joined the cast")
			if spectator ~= nil then
	            Self.Say("!cast ban " .. spectator)
	        end
	    end    
	end 
end 
Proxy.New("proxy")