--[[
    Script Name: 		Message responder
    Description: 		Respond both on default and PMs for incomming key messages. 
    Author: 			Ascer - example
]]

local SPPED_REACTION_FOR_MESSAGE = 500			-- miliseconds wait before start typing message
local SPEED_PER_LETTER = 90						-- miliseconds we spent for write one single letter
local STOP_CAVEBOT_WHEN_RESPONDING = true		-- while responding just stop cavebot for while.
local PLAY_SOUND = true							-- play sound on message appear.
local RESPOND_ONLY_TO_THIS = { 
	enabled = false,							-- enable true/false 
	nicks = {"Player", "GM"}					-- respond for messages from this players (nick names)
}

local RESPOND_KEYWORDS = {
	{key = {"bot", "afk"}, respond = {"no", "?", "what's up?", "lol"}},				-- key is string found in message, respond is random message to say.
	{key = {"hi", "hello", "yo"}, respond = {"hiho", "siema", "hola amigo"}},
	{key = {"where"}, respond = {"no idea", "use game wiki"}},
	{key = {"long", "exp"}, respond = {"need to gain huge level", "for next hour"}},
	--{key = {"*"}, respond = {"hello", "?"}}, -- * (star) mean any possible message 
}

-- DONT EDIT BELOW THIS LINE

local orders, responded, me = {}, {}, Self.Name()
RESPOND_ONLY_TO_THIS.nicks = table.lower(RESPOND_ONLY_TO_THIS.nicks)


function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if msg.channel < 2 and msg.mode < 8 and msg.speaker ~= me then 
			msg.message = string.lower(msg.message)
			if (RESPOND_ONLY_TO_THIS.enabled and table.find(RESPOND_ONLY_TO_THIS.nicks, string.lower(msg.speaker))) or not RESPOND_ONLY_TO_THIS.enabled then
				
				local name = nil
				if msg.channel == 0 and msg.mode == 4 then name = msg.speaker end

				local respond, key = keywordFound(msg.message)

				if respond ~= nil and not playerKeyExists(msg.speaker, key) then
					createOrder(respond, name)
					updatePlayerKey(msg.speaker, key)
				end

				if STOP_CAVEBOT_WHEN_RESPONDING then
					Cavebot.Enabled(false)
				end	

				if PLAY_SOUND then Rifbot.PlaySound() end
					
				print(msg.speaker, msg.message, msg.channel, msg.mode, msg.level) 
			end
		end		
	end 
end 
Proxy.New("proxy")

function executeOrder()
	for i, order in ipairs(orders) do
		if os.clock() - order.time > (order.delay / 1000) then
			if order.player ~= nil then
				Self.PrivateMessage(order.player, order.text, 0)
			else	
				Self.Say(order.text)
			end	
			table.remove(orders, i)
			wait(500, 900)
			if STOP_CAVEBOT_WHEN_RESPONDING then
				Cavebot.Enabled(true)
			end	
			return true
		end	
	end	
end	

function createOrder(msg, player)
	local order = {text = msg, time = os.clock(), delay = SPPED_REACTION_FOR_MESSAGE + (string.len(msg) * SPEED_PER_LETTER), player = player}
	table.insert(orders, order)
end	

function playerKeyExists(player, index)
	for i, key in ipairs(responded) do
		if key.name == player then
			if table.find(key.number, index) then
				return true
			end
		end
	end			
	return false
end	

function updatePlayerKey(player, index)
	for i, key in ipairs(responded) do
		if key.name == player then
			if not table.find(key.number, index) then
				table.insert(key.number, index)
				responded[i] = key
				return
			end	
		end	
	end
	table.insert(responded, {name = player, number = {index}})	
end	

function keywordFound(message)
	for i, element in ipairs(RESPOND_KEYWORDS) do
		for j, word in ipairs(element.key) do
			if string.find(message, "%f[%a]" .. word .. "%f[%A]") or word == "*" then
				return element.respond[math.random(1, #element.respond)], i
			end	
		end
	end
	return nil, nil	
end	

-- module to run in loop
Module.New("Message responder", function()
	executeOrder()
end)

-- module to remove already responded players every 2h
Module.New("Remove storage", function(mod)
	responded = {}
	mod:Delay(1000*60*60*2)
end)



