--[[
    Script Name: 		Change Attack Type on Player
    Description: 		Change Targeting Attack type/mode depend if player on screen.
    Author: 			Ascer - example
]]

local FRIENDS = {"friend1", "friend2"}                      -- ignore this friend list.
local TYPE = {player = "3sqm", noPlayer = "follow"}         -- set attack type depend on player or not
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


Module.New("Change Attack Type on Player", function (mod)
    local player = getPlayer()
    local targeting = Targeting.getAttackMode()

    if table.count(player) > 2 then
        if STOP_WALKER then
            if Walker.isEnabled() then
                Walker.Enabled(false)
            end
        end
        if targeting ~= TYPE.player then
            Targeting.setAttackMode(TYPE.player)
        end
    else 
        if STOP_WALKER then
            if not Walker.isEnabled() then
                Walker.Enabled(true)
            end
        end  
        if targeting ~= TYPE.noPlayer then
            Targeting.setAttackMode(TYPE.noPlayer)
        end    
    end
    mod:Delay(1000) --> execute actions every 1s
end)