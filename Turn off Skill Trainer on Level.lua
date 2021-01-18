--[[
    Script Name: 		Turn off Skill Trainer on Level
    Description: 		If your character reach level specifc level turn off skill trainer (attack mod)
    Author: 			Ascer - example
]]

local LEVEL = 8		-- what level to reach?


-- DON'T EDIT BELOW THIS LINE

Module.New("Turn off Skill Trainer on Level", function ()
	if Self.isConnected() then
		if Self.Level() >= LEVEL then
			Rifbot.setCheckboxState("skill trainer", "enabled", false)
		end	
	end	
end)
