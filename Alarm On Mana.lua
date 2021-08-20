--[[
    Script Name: 		Alarm On Mana
    Description: 		Play sound if your mana points are below MANA value.
    Author: 			Ascer - example
]]

local MANA = 1000				-- when mana will equal or above this value play sound.
local ALARM_NAME = "Low Mana.mp3" -- find more in Rifbot Lib.lua

Module.New("Alarm On Mana", function ()
	if Self.Mana() >= MANA then
		Rifbot.PlaySound(ALARM_NAME)
	end	
end)
