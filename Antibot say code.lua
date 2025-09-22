--[[
    Script Name:        Antibot say code
    Description:        Read game channels for incomming antibot message and type code. 
    					[IMPORTANT !] each game client could have their own messages. COPY ONLY CODE RELATED TO SERVER WHERE YOU PLAY.
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


-- RED CODE FROM WEAREDRAGONS Update: 2025-09-22

local POSSIBLE_ANTIBOT_CHANNELS = {13, 26, 27, 28, 29, 30, 9, 10, 11, 12, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25} -- respond to this channels, we don't know which is antibot so executing message every 2.5s on all from this list.

function extractNumbers(string)
	local numbers = {}
	for num in string.gmatch(string, "%d+") do
    	numbers[#numbers + 1] = num
	end
	return numbers
end --> return table with numbers extracted from string message


local var, respond, channelID = false, "", 0

function proxyChannelText(messages) 
	for i, msg in ipairs(messages) do 
		if string.instr(msg.message, "reminder:") then
			Rifbot.PlaySound()
			local nums = extractNumbers(msg.message)
			if table.count(nums) >= 2 and not var then
				--var = true
				respond = nums[1] + nums[2]
			end 
		end	
	end 
end 
Proxy.TextNew("proxyChannelText")

function proxyChannel(messages) 
	for i, msg in ipairs(messages) do 
		print(msg.speaker, msg.message, msg.channel, msg.mode, msg.level)
		if string.instr(msg.message, "reminder:") then
			Rifbot.PlaySound()
			local nums = extractNumbers(msg.message)
			if table.count(nums) >= 2 and not var then
				var = true
				respond = nums[1] + nums[2]
				channelID = msg.level
			end 
		end	
	end 
end 
Proxy.New("proxyChannel")

Module.New("executeRespond", function()
	if Self.isConnected() then
		if var then
			if channelID > 0 then
				print("Responding on channel " .. channelID .. " antibot result: " .. respond)
				Self.SayOnChannel(respond, channelID)
			else
				for i = 1, #POSSIBLE_ANTIBOT_CHANNELS do
					print("Responding on channel " .. POSSIBLE_ANTIBOT_CHANNELS[i] .. " antibot result: " .. respond)
					Self.SayOnChannel(respond, POSSIBLE_ANTIBOT_CHANNELS[i])
					wait(2500)
				end
			end	
			var = false
			respond = ""	
		end	
	end	
end)


