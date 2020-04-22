--[[
    Script Name: 		Enemy on Screen Alert
    Description: 		Play sound if enemy defected on screen. 
    Author: 			Ascer - example
]]

local ENEMY_LIST = {"Enemy1", "Enemy2"} -- add here enemies. Names need to by with Capital letter.

Module.New("Enemy on Screen Alert", function ()
    for i, player in pairs(Creature.iPlayers(7)) do
        if table.find(ENEMY_LIST, player.name) then
            playSound("Player On Screen.mp3") -- for more search in Rifbot Lib.lua -> RIFBOT_SOUNDS = []
            break -- break loop
        end
    end            
end)