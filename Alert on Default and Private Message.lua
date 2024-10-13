--[[
    Script Name:        Alert on Default and Private Message
    Description:        Play sound if someone send message on default or private. Safe list = Friends.txt
    Author:             Ascer - example
]]


local IGNORE_MESSAGES = {enabled = false, keywords = {"exura", "exura gran", "utevo lux"}} -- ignore common messages lower case use only

-- DON'T EDIT BELOW THIS LINE

local list = Rifbot.FriendsList(true)

--> here we adding our character name to safe list of message alert
local selfName = string.lower(Self.Name())
table.insert(list, selfName)

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if not table.find(list, string.lower(msg.speaker)) and msg.mode <= 5 and msg.channel <= 5 then
			if not IGNORE_MESSAGES.enabled or (IGNORE_MESSAGES.enabled and not table.find(IGNORE_MESSAGES.keywords, string.lower(msg.message))) then
				Rifbot.PlaySound("Default.mp3")
			end	
		end	
	end 
end 

-- register proxy message
Proxy.New("proxy")
