--[[
    Script Name: 		Take little break on exp
    Description: 		Do random break in exp session.
    Author: 			Ascer - example
]]

local EVERY_TIME_MINUTES = {20, 30}     -- do check every random 20-30min
local PAUSE_BREAK_MINUTES = {1, 3}      -- wait 1-3 min then continue 

local SCRIPTS = {"test", "runemaker"}   -- kill or load lua these lua scripts on break

-- DON'T EDIT BELOW THIS LINE

local breakTime, sessionTime, sessionDelay, breakDelay = 0, os.clock(), 0, 0

Module.New("Take little break on exp", function ()
    if Self.isConnected() then
        if breakDelay == 0 then
            sessionDelay = math.random(EVERY_TIME_MINUTES[1], EVERY_TIME_MINUTES[2])
            breakDelay = math.random(PAUSE_BREAK_MINUTES[1], PAUSE_BREAK_MINUTES[2])
        end    
        if os.clock() - sessionTime >= (sessionDelay*60) then
            if table.count(Creature.iMonsters(9, false)) <= 0  then
                Cavebot.Enabled(false)
                for i = 1, #SCRIPTS do
                    Rifbot.KillScript(SCRIPTS[i])
                    wait(500)
                end
                sessionTime = os.clock()
                breakTime = os.clock() 
            end    
        end
        if breakTime > 0 and os.clock() - breakTime >= (breakDelay*60) then
            for i = 1, #SCRIPTS do
                Rifbot.ExecuteScript(SCRIPTS[i])
                wait(500)
            end
            Cavebot.Enabled(true)
            breakTime = 0
            breakDelay = 0
        end    
    end        
end)