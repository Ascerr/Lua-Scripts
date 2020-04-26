--[[
    Script Name: 		Check Creature type
    Description: 		Check is creature is player, monster or NPC and write this in InformationBox
    Author: 			Ascer - example
]]


local PLAYER = "Player Name" -- name of player with Capital letter

-- Don't edit below this line.

Module.New("Check Creature type", function ()
    if Self.isConnected() then
        local players = Creature.iCreatures(7, false)
        for i = 1, #players do
            local player = players[i]
       		if player.name == PLAYER then
       			if Creature.isPlayer(player) then
       				printf("isPlayer")
       			elseif Creature.isMonster(player) then
       				printf("isMonster")
       			else
       				printf("isNPC")	
       			end
       			break
       		end	
        end
    end
end)
