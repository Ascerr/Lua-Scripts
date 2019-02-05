--[[
    Script Name: 		Creature Attack
    Description: 		Play sound if any monster or player attack you. 
    Author: 			Ascer - example
]]

local SAFE_LIST = {"Defense Monster", "Friend2"} -- add here your training friend or defense monster for example. Names need to by with Capital letter.

Module.New("Player Alarm", function (mod)
    for i, player in pairs(Creature.iPlayers(7)) do
        if not table.find(SAFE_LIST, player.name) then
            playSound("Macro Test.wav") -- for more search in Rifbot Lib.lua -> RIFBOT_SOUNDS = []
            break -- break loop
        end
    end            
    mod:Delay(200)
end)