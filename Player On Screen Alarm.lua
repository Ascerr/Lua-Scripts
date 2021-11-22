--[[
    Script Name: 		Creature Attack
    Description: 		Play sound if any monster or player attack you. 
    Author: 			Ascer - example
]]

local SAFE_LIST = {"Friend1", "Friend2"}  -- add here your training friend or defense monster for example. Names need to by with Capital letter.
local MINIMAL_TIME_STAY_ON_SCREEN = 0     -- minimal amount of miliseconds (1000ms = 1s) player stay on screen to alert. For 5s put 5000 

-- DON'T EDIT BELOW THIS LINE

local enterTime = 0

-- loop function
Module.New("Player Alarm", function ()
    local isPlayer = false
    for i, player in pairs(Creature.iPlayers(7)) do
        if not table.find(SAFE_LIST, player.name) then
            isPlayer = true
            if enterTime <= 0 then
                enterTime = os.clock()
            end
            if enterTime > 0 then
                if os.clock() - enterTime >= (MINIMAL_TIME_STAY_ON_SCREEN / 1000) then
                    playSound("Macro Test.wav") -- for more search in Rifbot Lib.lua -> RIFBOT_SOUNDS = []
                    break -- break loop
                end    
            end    
        end
    end
    if not isPlayer then enterTime = 0 end -- when no player reset time.
end)