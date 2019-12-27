--[[
    Script Name:        Cast Spell On Time
    Description:        Cast spell every some time.
    Author:             Ascer - example
]]

local SPELL = "adura vita"          -- spell we will cast ig game

local EVERY_TIME_SECONDS = 200      -- every this time in seconds will countinue cast spell

local ADD_RANDOM = false            -- add random time +5, 10 seconds [true/false]

-- DONT'T EDIT BELOW THIS LINE

local mainTime, randomTime = 0, 0

-- mod to run functions
Module.New("Cast Spell On Time", function ()
    
    -- check if we should login.
    if (os.clock() - mainTime) >= (EVERY_TIME_SECONDS + randomTime)  then
        
        -- if we are connected to game.
        if Self.isConnected() then

            Self.CastSpell(SPELL, 0)

            -- set time casting spell   
            mainTime = os.clock()

            -- if we adding extra random time
            if ADD_RANDOM then

                -- set random time
                randomTime = math.random(5, 10)

            end    

        end

    end        

end) 
