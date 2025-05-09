--[[
    Script Name: 		PM With Players On Screen
    Description: 		Check for players on screen and pm to other character with their names
    Author: 			Ascer - example
]]

local RECEIVERS = {"Receiver1", "Receiver2"}               -- characters to receive messages.
local SAFE_LIST = {"friend1", "friend2"}        -- avoid sending message with your friends
local INSTANT = true                            -- send message always or only when a new player enter on screen
local SPEAK_DELAY = 3                           -- time in seconds between sending msg.
local MULTIFLOOR = false                        -- true/false check players on multiple floors

-- DON'T EDIT BELOW THIS LINE

local storage, speakTime = {}, 0
local sayStartTime, sayLastTime, sayMessageCount = 0, 0, 0

function pm(player, text, delay)
    if not delay then delay = 2000 end
    if os.clock() - sayStartTime >= 10 then
        sayMessageCount = 0
        sayStartTime = 0
    end        
    if sayMessageCount < 6 and os.clock() - sayLastTime >= (delay/1000) then
        Self.PrivateMessage(player, text, 0)
        sayMessageCount = sayMessageCount + 1
        sayLastTime = os.clock()
        if sayMessageCount == 1 then
            sayStartTime = os.clock()
        end
        return true        
    end
    return false    
end 

Module.New("PM With Players On Screen", function ()
    local names, amount = "", 0
    if os.clock() - speakTime > SPEAK_DELAY then
        for i, player in pairs(Creature.iPlayers(7, MULTIFLOOR)) do
            if not table.find(SAFE_LIST, player.name) then
                if not INSTANT then
                    if not table.find(storage, player.name) then
                        table.insert(storage, player.name)
                        names = names .. player.name .. ", "
                        amount = amount + 1
                    end
                else
                    names = names .. player.name .. ", "
                    amount = amount + 1    
                end    
            end
        end
        if names ~= "" then
            for i = 1, #RECEIVERS do
                pm(RECEIVERS[i], "On screen (" .. amount .. ") " .. names, 0)
            end    
            speakTime = os.clock()   
        end
    end        
end)
