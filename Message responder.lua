--[[
    Script Name: 		Message responder
    Description: 		Respond for message on chat
    Author: 			Ascer - example
]]

local SPPED_REACTION_FOR_MESSAGE = 500			-- miliseconds wait before start typing message
local SPEED_PER_LETTER = 90						-- miliseconds we spent for write one single letter
local RESPOND_TO = {"Player", "GM"}				-- respond for messages from this players (nick names)
local RANDOM_RESPOND_WORDS = {"siema byku", "yo", "ello", "hiho", "yoyo"}		-- use thi random words to respond

-- DONT EDIT BELOW THIS LINE

local orders = {}
RESPOND_TO = table.lower(RESPOND_TO)

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if table.find(RESPOND_TO, string.lower(msg.speaker)) then
			createOrder(RANDOM_RESPOND_WORDS[math.random(1, #RANDOM_RESPOND_WORDS)])
			Rifbot.PlaySound()
			print(msg.speaker, msg.message, msg.channel, msg.mode, msg.level) 
		end	
	end 
end 

function executeOrder()
	for i, order in ipairs(orders) do
		if os.clock() - order.time > (order.delay / 1000) then
			Self.Say(order.text)
			table.remove(orders, i)
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

-- register new proxy
Proxy.New("proxy")



