--[[
    Script Name: 		Alarm when pushed
    Description: 		Play sound when your character pushed. Run script when you will online only.
    Author: 			Ascer - example
]]

local SOUND = "Creature Detected.mp3" -- sound name more inside Ribot folder\Alarms


-- DON'T EDIT BELOW THIS LINE
local pushed, startPos = false, Self.Position()


Module.New("Alarm when pushed", function ()
    
    -- when self is connected.
    if Self.isConnected() then

        -- when var contains true
        if pushed then

            -- play sound
            Rifbot.PlaySound(SOUND)

        -- check if all is fine.
        else    

            -- when distance from pos is different than current we set.
            if Self.DistanceFromPosition(startPos.x, startPos.y, startPos.z) ~= 0 then

                -- set var.
                pushed = true

            end    

        end    

    end    

end)
