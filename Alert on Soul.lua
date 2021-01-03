--[[
    Script Name:        Alert on Soul
    Description:        Play sound when low soul points
    Author:             Ascer - example
]]

local SOUL = 50		-- when your soul points will equal or below this amount play sound.

--  DON'T EDIT BELOW THIS LINE

Module.New("Alert on Soul", function (mod)
	if Self.isConnected() then
		if Self.Soul() <= SOUL then
			Rifbot.PlaySound("Default.mp3")
			printf("Alert: Low soul points")
		end
	end			
	mod:Delay(300, 1200) -- set random delay
end)
