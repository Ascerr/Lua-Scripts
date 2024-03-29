--[[
    Script Name: 		Stop Bot on Player
    Description: 		Stop bot when player out of friends list is on screen else enable.
    Author: 			Ascer - example
]]

local FRIENDS = {"friend1", "friend2"}      -- friends nicks to avoid
local PAUSE_LUA_SCRIPTS = false             -- disable lua scripts too !WARRING script don't restore bot again, you will need to manually press Ctrl+P

-- DONT'T EDIT BELOW THIS LINE 

local list = table.lower(FRIENDS)

Module.New("Stop Bot on Player", function ()
	local players = Creature.iPlayers(7, false) -- get players on screen only
    for i = 1, #players do
        local player = players[i]
        if not table.find(list, string.lower(player.name)) then
            return Rifbot.setEnabled(false, PAUSE_LUA_SCRIPTS) -- disable player when player on screen.
        end
    end
    Rifbot.setEnabled(true) -- enable bot not players found
end)
