--[[
    Script Name: 		Advertising
    Description: 		Advert your message on Trade and Default channel as Yell.
    Author: 			Ascer - example
]]

local TRADE = {true, 180, 400} 				-- advert on trade true/false, random time: 180-400s
local DEFAULT_YELL = {true, 80, 250}		-- advert on default as yell true/false, random time: 80-250s

local MESSAGES = {							-- messages, could be single or group (if group then random)
	"Sell bps of uh, sd",
	"Buy golden account!"
}


-- DON'T EDIT BELOW THIS LINE

local tradeTime, tradeDelay, yellTime, yellDelay = 0, 0, 0, 0

Module.New("Advertising", function ()
	local items = table.count(MESSAGES)
	if TRADE[1] then
		if os.clock() - tradeTime > tradeDelay then
			Self.SayOnChannel(MESSAGES[math.random(1, items)], CHANNEL_ADVERTISING)
			tradeTime = os.clock()
			tradeDelay = math.random(TRADE[2], TRADE[3]) -- divide by 1000 is no need sice os.clock() return seconds
			if DEFAULT_YELL[1] then
				wait(3000, 7000) -- wait between trade and yell message
			end
		end
	end
	if DEFAULT_YELL[1] then
		if os.clock() - yellTime > yellDelay then
			Self.Yell(MESSAGES[math.random(1, items)])
			yellTime = os.clock()
			yellDelay = math.random(DEFAULT_YELL[2], DEFAULT_YELL[3])
		end
	end		
end)
