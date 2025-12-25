--[[
    Script Name:        Sell items based on green message
    Description:        Hotkey use item, appear green message read item and count then sell it via npc say.
    
    Required:			1. Minimal rifbot version 3.10 release 2025-12-16 or later. 
    					2. Server which sending green messages about using items from hotkeys.
    					3. Valid message check in lines 45, 49, 51. Current based on this is "Using one of 27 gold coins..." and "Using the last leather helmet..."
    					4. Correct ids type: 0 - use, 1 - usewith because on some server you just can't use item like sabre to generate message you need usewith, otherway leather helmet can be just used.
    					5. How to run? Near npc add walker code to load script and wait some time. Script auto close itself when will done.
    					
    					stand: 32343, 32344, 7
    					lua: lua: Rifbot.ExecuteScript("Sell items based on green message")
    					wait: 5000

    Author:             Ascer - example
]]


local ids = {{3361, 0}, {3355, 0}, {3273, 1}}		-- ids to use and sell based on message {id, type} @id -item id, @type: 0 - use, 1 - usewith. Some items can't be just used and must be used on yourself to generate green message
local npcTalk = false								-- use npc mode talk (true) or default say channel (false)
local sellItemDelay = 1000							-- sell item every 1s

-- DON'T EDIT BELOW

local index = 1
local processing = false
Self.Say("hi") --> Say hi to npc

Module.New("Sell items based on green message", function(mod)
	if Self.isConnected() then 
		if not processing then
			if index <= table.count(ids) then
				local item = ids[index] 
				if item[2] == 0 then
					Self.UseItem(item[1], false, 0) --> just use item 0 delay
				else	
					Self.UseItemWithMe(item[1], 0) --> using item WITH me 0 delay
				end
				index = index + 1
			else	
				Rifbot.KillScript(Rifbot.GetScriptName()) --> kill script when all is done
			end	
		end	
	end
	mod:Delay(sellItemDelay)	
end)


function proxyText(messages) 
	for i, msg in ipairs(messages) do 
		local str1, str2 = string.instr(msg.message, "Using one of"), string.instr(msg.message, "Using the last")
		local message = ""
		if str1 or str2 then -- here message we checking if in message there is keyword: "Using one of"
			if str1 then
				message = string.sub(string.sub(msg.message, 14, -1), 1, -4) -- select only amount and name of item: string.sub(msg.message, 14, -1) -> removes first 14 letters in this case "Using one of ", string.sub(msg.message, 1, -4) -> removes last 3 letters in this case "..."
			elseif str2 then
				message = string.sub(string.sub(msg.message, 16, -1), 1, -4) -- second type of message
			end	
			print(message)
			if string.len(message) > 2 then
				--print("separated message item from text: " .. message)
				processing = true
				if npcTalk then
					Self.SayNpc("sell " .. message)
					Self.SayNpc("yes")
				else
					Self.Say("sell " .. message)
					Self.Say("yes")
				end	
				processing = false
			end	
		end	
	end 
end 
Proxy.TextNew("proxyText")
