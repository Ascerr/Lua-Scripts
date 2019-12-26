--[[
    Script Name: 		On Player Say Text
    Description: 		Say text when character enter screen. Read config for more info.
    Author: 			Ascer - example
]]

local SAFE_LIST = {"friend1", "friend2"} -- set a safe list

local RANGE = 7 -- say text when player distance from you is .. (7 is deafult all screen)

local WAIT_SAY_ON_PLAYER_FOCUS = 2000 -- wait this miliseconds after player enter scren to say message

local RESPOND_MESSAGES = {"hola amigo what skills?", "How are you?", "If you want to kill me go on i wait..", "Don't take make food", "have food?"}


-- DON'T EDIT BELOW THIS LINE

local markedPlayers = {}

Module.New("On Player Say Text", function ()
    
    -- check for self connections
    if Self.isConnected() then
        
        -- load all players
        local players = Creature.iPlayers(RANGE, false)
        
        -- in loop for all players
        for i = 1, #players do
            
            -- load single player
            local player = players[i]
            
            -- check for safe list
            if not table.find(SAFE_LIST, player.name) and not table.find(markedPlayers, player.name) then
                
                -- wait some miliseconds before say message
                wait(WAIT_SAY_ON_PLAYER_FOCUS)

                -- say message
                Self.Say(RESPOND_MESSAGES[math.random(#RESPOND_MESSAGES)])

                -- add player to array we don't respond again.
                table.insert(markedPlayers, player.name)

            end

        end

    end
   
end)
