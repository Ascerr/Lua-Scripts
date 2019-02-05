--[[
    Script Name: 		Creature Attack
    Description: 		Play sound if any monster or player attack you. 
    Author: 			Ascer - example
]]

local SAFE_LIST = {"Defense Monster", "Friend2"} -- add here your training friend or defense monster for example. Names need to by with Capital letter.

Module.New("Creature Attack", function (mod)
    for i, mob in pairs(Creature.getCreatures()) do
        if not table.find(SAFE_LIST, mob.name) then
            if mob.attack == 1 then
                Rifbot.PlaySound("Player Attack.mp3") -- for more search in Rifbot Lib.lua -> RIFBOT_SOUNDS = []
                break -- break loop
            end
        end
    end            
    mod:Delay(200)
end)