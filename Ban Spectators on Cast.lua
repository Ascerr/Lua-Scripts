--[[
    Script Name:        Ban Spectators on Cast

    Description:        Auto ban new spectators joined to your cast. 
    Required:			Valid message about joined specator inside line 16 or 29.              
    Author:             Ascer - example 
]]

local USE_PROXY_TEXT = false	-- true/false use different method to catching signals example on Kasteria

if not USE_PROXY_TEXT then

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

else

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		local spectator = string.match(msg.message, "(.+) joins your stream.")
		if spectator ~= nil then
            Self.Say("!cast ban " .. spectator)
        end   
	end 
end 
Proxy.TextNew("proxy")

end
