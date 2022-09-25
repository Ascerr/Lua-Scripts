--[[
    Script Name: 		Auto Private Message Respond
    Description: 		Respond for message on chat
    Author: 			Ascer - example
]]

local config = {
	respond = {"Hello", "Hiho", "Hi"}, 		-- random message to pm respond
	once = true,							-- true/false respond to player only once per 2h.
}

-- DONT EDIT BELOW THIS LINE
local responded = {Self.Name()}


function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if msg.channel == 0 and msg.mode == 4 then
			msg.message = string.lower(msg.message)
			if not table.find(responded, msg.speaker) and config.once then
				Self.PrivateMessage(msg.speaker, config.respond[math.random(1, #config.respond)], 0)
				table.insert(responded, msg.speaker)
				print(msg.speaker .. ": " .. msg.message)
				--print(msg.speaker, msg.message, msg.channel, msg.mode, msg.level) 
			end
		end		
	end 
end 


-- module to remove already responded players every 2h
Module.New("Remove storage", function(mod)
	responded = {Self.Name()}
	mod:Delay(1000*60*60*2)
end)

-- register new proxy
Proxy.New("proxy")



