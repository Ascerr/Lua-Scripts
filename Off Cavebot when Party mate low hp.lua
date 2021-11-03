--[[
    Script Name: 		Off Cavebot when Party mate low hp
    Description: 		If you or anyone else from party will have low hp then script disable cavebot.
    Author: 			Ascer - example
]]


local HPPERC = 40       -- when someone from party on screen have less than 40 hp disable cavebot.

-- DONT EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getPartyMateWithLowHpperc(hp)
--> Description:    Get table with player from party that have hpperc less than @hp.
--> Params:         
-->                 @hp - number health percent below this return player.
--> Return:         table with player info or -1 if not found.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPartyMateWithLowHpperc(hp)

    -- for players on screen
    for i, player in ipairs(Creature.iPlayers(7, false)) do

        -- when is party mate
        if Creature.isPartyMember(player) or Creature.isPartyLeader(player) then

            -- when low hp
            if player.hpperc < hp then

                -- return current mate.
                return player

            end    

        end 

    end

    -- return -1 player not found
    return -1

end 


Module.New("Off Cavebot when Party mate low hp", function ()
    
    -- when connected
    if Self.isConnected() then

        -- check if any mate have low hp
        local mate = getPartyMateWithLowHpperc(HPPERC)
       
        -- when mate found
        if mate ~= -1 then

            -- when cavebot is enabled disable.
            if Walker.isEnabled() then Walker.Enabled(false) end
            if Targeting.isEnabled() then Targeting.Enabled(false) end
            if Looter.isEnabled() then Looter.Enabled(false) end

        end    

    end    

end)