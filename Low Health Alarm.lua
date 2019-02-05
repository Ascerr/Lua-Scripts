--[[
    Script Name: 		Low Health Alarm
    Description: 		Play sound if your health is below 50%.
    Author: 			Ascer - example
]]

local HPPERC = 50
local ALARM_NAME = "Low Health.mp3" -- find more in Rifbot Lib.lua

Module.New("Low Health", function (mod)
	if Self.HealthPercent() < HPPERC then
		Rifbot.PlaySound(ALARM_NAME)
	end	
	mod:Delay(200, 500)
end)
