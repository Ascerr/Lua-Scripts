--[[
    Script Name:        Alert on keyword in game
    Description:        Check bot default/private/server log chats for specific keywords and alert when appear.
    Author:             Ascer - example
]]

local KEYWORDS = {"Uhzudo Roxtonzera","<--- Xonk --->", "other keyword to detect#", "You lose"}     -- keywords to detect
local PAUSE_BOT = false                                                                             -- true/false pause bot.

-- DON'T EDIT BELOW.

function isKeyword(msg)
	for i = 1, #KEYWORDS do
		if string.instr(msg, KEYWORDS[i]) then
			return true
		end 
	end
	return false	
end	--> check if specific keyword from possible keywords list appear in message 

function proxyText(messages) 
	for i, msg in ipairs(messages) do 
		if isKeyword(msg.message) then
			print("proxyText: " .. msg.message, msg.mode) 
			Rifbot.PlaySound()
            if PAUSE_BOT then
                Rifbot.setEnabled(false, true)
            end    
		end	
		
	end 
end 
Proxy.TextNew("proxyText")

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if isKeyword(msg.message) then
			print("proxy: " .. msg.speaker, msg.message, msg.channel, msg.mode, msg.level)
			Rifbot.PlaySound()
            if PAUSE_BOT then
                Rifbot.setEnabled(false, true)
            end   
		end
		
	end 
end 
Proxy.New("proxy")					
