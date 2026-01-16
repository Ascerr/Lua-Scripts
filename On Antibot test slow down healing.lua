--[[
    Script Name: 		On Antibot test slow down healing
    Description: 		When you will under antibot test {catching keyword from on sever log} then default bot panel will be paused and this lua will heal your character with 1s+ delay.
    Author: 			Ascer - example
]]


local SAFE_HEAL_BELOW = 50										-- heal with delay if below this value %
local HEAL_TYPE = {method = "spell", object = "exura vita"}		-- healing type @method "rune" or "spell", @object rune ID or "spell name"
local DELAY = {1200, 1500}										-- execute healing with this delay slow motion
local KEYWORD = "tested by our anti-bot system"					-- catch for this keyword.

-- DON'T EDIT BELOW THIS LINE

local startTime, startDelay = 0, 0
Module.New("On Antibot test slow down healing", function()
	if Self.isConnected() then
		if Self.HealthPercent() <= SAFE_HEAL_BELOW then
			if startTime == 0 then
				startTime = os.clock()
				startDelay = math.random(DELAY[1], DELAY[2])
			else	
				if os.clock() - startTime > (startDelay/1000) then
					if HEAL_TYPE.method == "rune" then
						Self.UseItemWithMe(tonumber(HEAL_TYPE.object)) --> heal with rune
					else
						Self.Say(HEAL_TYPE.object) --> heal with spell
						wait(1000, 1500)
					end	
				end	
			end
		else		
			wait(1500, 2000) -- waits some time to restore back bot from paused state.
			startTime = 0
			startDelay = 0
			if not Rifbot.isEnabled() then 
				Rifbot.setEnabled(true) 
			end 
		end	
	end	
end)

function proxyText(messages) 
	for i, msg in ipairs(messages) do 
		if string.find(msg.message, KEYWORD) then
			print(msg.message, msg.mode)
			if Rifbot.isEnabled() then 
				Rifbot.setEnabled(false) 
			end
		end	
	end 
end
Proxy.TextNew("proxyText")