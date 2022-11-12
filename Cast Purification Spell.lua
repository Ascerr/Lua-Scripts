--[[
    Script Name:        Cast Purification Spell
    Description:        When you hpperc decrease below x then character will cast purification spell once.
    Author:             Ascer - example
]]

local spell = {
    hpperc = 70 ,                   -- when hpperc will below.
    name = "purification",          -- spell to cast
    time = 80                       -- spell time in seconds
}


-- DONT'T EDIT BELOW THIS LINE
local mainTime = -999


-- mod to run functions
Module.New("Cast Purification Spell", function ()
    
    -- if we are connected to game.
    if Self.isConnected() then

        -- check if we should cast.
        if (os.clock() - mainTime) >= spell.time then
            
            -- when hpperc will below.
            if Self.HealthPercent() < spell.hpperc then

                -- cast spell
                Self.Say(spell.name)

                -- update time
                mainTime = os.clock()

            end    

        end

    end    

end) 
