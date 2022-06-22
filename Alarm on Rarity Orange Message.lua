--[[
    Script Name:        Alarm on Rarity Orange Message
    
    Description:        Play sound when after killing monster appear orange message "Rarity"              
    Author:             Ascer - example 
]]


-- DON'T EDIT BELOW

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if msg.message == "Rarity" and msg.mode == 34 then
			if msg.speaker == Self.Name() then
				Rifbot.PlaySound()
				print("Rarity item dropped!")
			end	
		end	

	end 
end
Proxy.New("proxy")