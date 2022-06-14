--[[
    Script Name: 		Message responder
    Description: 		Respond for message on chat
    Author: 			Ascer - example
]]

local SPPED_REACTION_FOR_MESSAGE = 500			-- miliseconds wait before start typing message
local SPEED_PER_LETTER = 90						-- miliseconds we spent for write one single letter
local RESPOND_TO = {"Player", "GM"}				-- respond for messages from this players (nick names)
local RESPOND_TO_EVERYONE = false				-- true/false respond for every possible nick.
local STOP_CAVEBOT_WHEN_RESPONDING = false		-- while responding just stop cavebot for while.
local RANDOM_RESPOND_WORDS = {"siema byku", "yo", "ello", "hiho", "yoyo"}		-- use the random words to respond

-- DONT EDIT BELOW THIS LINE

local orders, responded = {}, {Self.Name()}
RESPOND_TO = table.lower(RESPOND_TO)

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if msg.channel < 2 and msg.mode < 8 then
			if table.find(RESPOND_TO, string.lower(msg.speaker)) or RESPOND_TO_EVERYONE then
				if not table.find(responded, msg.speaker) then
					table.insert(responded, msg.speaker)
					createOrder(RANDOM_RESPOND_WORDS[math.random(1, #RANDOM_RESPOND_WORDS)])
					Rifbot.PlaySound()
					if STOP_CAVEBOT_WHEN_RESPONDING then
						Cavebot.Enabled(false)
					end	
				end	
				print(msg.speaker, msg.message, msg.channel, msg.mode, msg.level) 
			end
		end		
	end 
end 

function executeOrder()
	for i, order in ipairs(orders) do
		if os.clock() - order.time > (order.delay / 1000) then
			Self.Say(order.text)
			table.remove(orders, i)
			wait(500, 900)
			if STOP_CAVEBOT_WHEN_RESPONDING then
				Cavebot.Enabled(true)
			end	
			return true
		end	
	end	
end	

function createOrder(msg)
	local order = {text = msg, time = os.clock(), delay = SPPED_REACTION_FOR_MESSAGE + (string.len(msg) * SPEED_PER_LETTER)}
	table.insert(orders, order)
end	

-- module to run in loop
Module.New("Message responder", function()
	executeOrder()
end)

-- module to remove already responded players every 2h
Module.New("Remove storage", function(mod)
	responded = {Self.Name()}
	mod:Delay(1000*60*60*2)
end)

-- register new proxy
Proxy.New("proxy")
