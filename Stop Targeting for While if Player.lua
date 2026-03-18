--[[
    Script Name: 		Stop Targeting for While if Player
    Description: 		Stop targeting when player out of friends list is on screen and enable after x time.
    Author: 			Ascer - example
]]

local FRIENDS = {"friend1", "friend2"}                      -- ignore this friend list.
local ENABLE_TARGETING_AFTER_SECONDS = 30                   -- enable targeting after 30 seconds no matter if player still follow you
local STOP_WALKER = false                                   -- true/false stop walker or not

-- DONT'T EDIT BELOW THIS LINE 

local list, action = table.lower(FRIENDS), 0

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getPlayer()
--> Description:    Read for players on screen.
--> Class:          none
--> Params:         None
--> Return:         If found return table player else return false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPlayer()
    local players = Creature.iPlayers(7, false) -- get players on screen only
    for i = 1, #players do
        local player = players[i]
        if not table.find(list, string.lower(player.name)) then
            return player
        end
    end
    return false    
end    


Module.New("Stop Targeting for While if Player", function ()
	
    -- get player
    local player = getPlayer()
    
    -- read current state of walker and targeting
    local targeting = Targeting.isEnabled()
    
    -- if player detected
    if table.count(player) > 2 then

        -- when action not started or still targeting is enabled
        if action == 0 then

            -- stop walker module.
            if STOP_WALKER then
                if Walker.isEnabled() then
                    Walker.Enabled(false)
                end
            end        

            -- disable targeting and walker when enabled.
            if targeting then 
                
                -- disable targeting
                Targeting.Enabled(false)

            else
                
                -- save time
                action = os.clock()

            end

        end

    end    

    -- when time diff between disable
    if action > 0 and os.clock() - action > ENABLE_TARGETING_AFTER_SECONDS then

        -- starts walker module.
        if STOP_WALKER then
            if not Walker.isEnabled() then
                Walker.Enabled(true)
            end
        end  

        if not targeting then 
            Targeting.Enabled(true) 
        else    
            action = 0
        end

    end

end)
