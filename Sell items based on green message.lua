--[[
    Script Name:        Sell items based on green message
    Description:        Hotkey use item, appear green message read item and count then sell it via npc say.
    
    Required:			1. Minimal rifbot version 3.10 release 2025-12-16 or later. 
    					2. Server which sending green messages about using items from hotkeys.
    					3. Valid message check in lines 37, 38. Current based on this is "Using one of 27 gold coins..."
    					4. How to run? Near npc add walker code to load script and wait some time. Script auto close itself when will done.
    					
    					stand: 32343, 32344, 7
    					lua: lua: Rifbot.ExecuteScript("Sell items based on green message")
    					wait: 5000

    Author:             Ascer - example
]]


local ids = {3361, 3552, 3355}		-- ids to use/sell them
local npcTalk = true				-- use npc mode talk (true) or default say channel (false)


-- DON'T EDIT BELOW

local index = 1
local processing = false
Self.Say("hi") --> Say hi to npc

Module.New("Sell items based on green message", function(mod)
	if Self.isConnected() then 
		if not processing then
			if index <= table.count(ids) then
				Self.UseItem(ids[index], false, 0) --> using items with 0 delay
				index = index + 1
			else	
				Rifbot.KillScript(Rifbot.GetScriptName()) --> kill script when all is done
			end	
		end	
	end
	mod:Delay(500)	
end)


function proxyText(messages) 
	for i, msg in ipairs(messages) do 
		if string.instr(msg.message, "Using one of") then -- here message we checking if in message there is keyword: "Using one of"
			local message = string.sub(string.sub(msg.message, 14, -1), 1, -4) -- select only amount and name of item: string.sub(msg.message, 14, -1) -> removes first 14 letters in this case "Using one of ", string.sub(msg.message, 1, -4) -> removes last 3 letters in this case "..."
			if string.len(message) > 2 then
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