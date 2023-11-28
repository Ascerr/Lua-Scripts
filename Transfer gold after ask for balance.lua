--[[
    Script Name:        Transfer gold after ask for balance
    Description:       	When you will in bank and ask npc for balance then bot read proxy and get amount then transfer all to selected person.
    Author:             Ascer - example
]]


local npcName = "Suzy"					--> name of NPC
local transferPerson = "Character Name"	--> name of person we transfer cash
local speakNPC = false					--> true/false speak in NPC chanel (possible on some servers)

-- DON'T EDIT BELOW

local balance, canTransfer = 0, false

function proxy(messages) 
    for i, msg in ipairs(messages) do 
        if msg.speaker == npcName then
        	balance = string.match(msg.message, "Your account balance is (.+) gold.") --> this message can be different depend on server and amount you have
        	if balance ~= nil then
        		balance = tonumber(balance)
        		if balance > 0 then
	        		canTransfer = true
	        	end	
        	end
        end		
    end 
end
Proxy.New("proxy")

--> module to execute transfer action with wait imitation of Player.
Module.New("Transfer gold after ask for balance", function()
	if canTransfer then
		if speakNPC then
			Self.SayNpc("transfer")
			wait(800)
			Self.SayNpc(balance)
			wait(800)
			Self.SayNpc(transferPerson)
			wait(500)
			Self.SayNpc("yes")
		else	
			Self.Say("transfer")
			wait(800)
			Self.Say(balance)
			wait(800)
			Self.Say(transferPerson)
			wait(500)
			Self.Say("yes")
		end	
		canTransfer = false
		balance = 0
	end	
end)