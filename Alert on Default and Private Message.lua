--[[
    Script Name:        Alert on Default and Private Message
    Description:        Play sound if someone send message on default or private. Safe list = Friends.txt
    Author:             Ascer - example
]]


local list = Rifbot.FriendsList(true)

--> here we adding our character name to safe list of message alert
local selfName = string.lower(Self.Name())
table.insert(list, selfName)

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if not table.find(list, string.lower(msg.speaker)) and msg.mode <= 5 and msg.channel <= 5 then
			print(msg.speaker, msg.message, msg.channel, msg.mode, msg.level)
			Rifbot.PlaySound("Default.mp3")
		end	
	end 
end 

-- register proxy message
Proxy.New("proxy")
