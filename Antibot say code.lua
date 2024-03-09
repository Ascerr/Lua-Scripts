--[[
    Script Name:        Antibot say code
    Description:        Read game channels for incomming antibot message and type code. [IMPORTANT !] each game client could have their own messages.
    Author:             Ascer - example
]]


-- RED CODE FROM KELTERA
function proxyText(messages) 
	for i, msg in ipairs(messages) do 
		print(msg.message, msg.mode)
		if string.instr(msg.message, "antibot") then
			Rifbot.PlaySound()
			local code = string.match(msg.message, '%d+')
			if code ~= nil then
				code = tonumber(code)	
				if code > 100 then
					Self.Say("!antibot " .. code)
				end	
			end	
		end	
	end 
end 
Proxy.TextNew("proxyText")


--ORANGE CODE FROM CLASSICK74
local t = 0
local me = Self.Name()

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if string.instr(msg.message, "[anti-bot]") then
			print("Received [anti-bot] msg: " .. msg.message)
			Rifbot.PlaySound()
			t = 1
		else	
			if t > 0 then
				if msg.speaker == me and msg.channel == 43 then
					local code = tonumber(string.match(msg.message, '%d+'))
					if code > 100 then
						Self.Say("!antibot " .. code)
						t = 0
					end	
				end	
			end	
		end
	end		
end
Proxy.New("proxy")
