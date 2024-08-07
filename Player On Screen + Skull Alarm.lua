--[[
    Script Name: 		Player On Screen + Skull Alarm
    Description: 		Play sound player is on screen. (configurable safe list, time required to player stay on screen, check only for skulls) 
    Author: 			Ascer - example
]]

local SAFE_LIST = {"Friend1", "Friend2"}  -- add here your training friend or defense monster for example. Names need to by with Capital letter.
local MINIMAL_TIME_STAY_ON_SCREEN = 0     -- minimal amount of miliseconds (1000ms = 1s) player stay on screen to alert. For 5s put 5000 
local CHECK_ONLY_FOR_SKULLS = false       -- true/false check only for players that have skull red or white
local MULTIFLOOR = false                  -- true/false check for players above/below

-- DON'T EDIT BELOW THIS LINE

local enterTime = 0

-- loop function
Module.New("Player On Screen + Skull Alarm", function ()
    local isPlayer = false
    for i, player in pairs(Creature.iPlayers(7, MULTIFLOOR)) do
        if not table.find(SAFE_LIST, player.name) and (not CHECK_ONLY_FOR_SKULLS or (CHECK_ONLY_FOR_SKULLS and player.skull >= SKULL_WHITE)) then
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
