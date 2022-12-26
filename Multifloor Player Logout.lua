--[[
    Script Name: 		Multifloor Player Logout
    Description: 		Logout when character detected on multiple floors.
    Author: 			Ascer - example
]]

local FRIENDS = {"friend1", "friend2"} 		-- list of friends
local DONT_LOGOUT_WHEN_GM_APPEAR = {enabled = true, keywords = {"GM ", "CM ", "Admin ", "ADM ", "Gamemaster"}}
local BELOW = true							-- check for players below you
local ABOVE = false							-- check for player above you
local LEVELS = 2							-- search for one floor above or below / limit is 2 / do not check floors below on level 7
local RELOGIN = {enabled = true, delay = 0.1} -- relogin to game when player detected or lost connection. enabled = true/false, delay = 6 min or immediately when lost connection

-- DON'T EDIT BELOW THIS LINE

FRIENDS = table.lower(FRIENDS) -- convert table to lower strings.
logoutTime, printfTime, LOGOUT_TIME, LAST_PLAYER = 0, 0, "", ""

function isGM(name)
	for j = 1, #DONT_LOGOUT_WHEN_GM_APPEAR.keywords do
        if string.instr(name, DONT_LOGOUT_WHEN_GM_APPEAR.keywords[j]) then return true end
    end
    return false     	
end	--> check is name contains GM keywords.

Module.New("Multifloor Player Logout", function (mod)
	if Self.isConnected() then
		LAST_PLAYER = ""
		logoutTime = 0
		local selfpos = Self.Position()
		for i, player in pairs(Creature.iPlayers(7, true)) do  -- get only above and below
			if not table.find(FRIENDS, string.lower(player.name)) and (not DONT_LOGOUT_WHEN_GM_APPEAR.enabled or (DONT_LOGOUT_WHEN_GM_APPEAR.enabled and not isGM(player.name))) then
				local var = (BELOW and (selfpos.z - player.z) <= 0 and (selfpos.z - player.z) >= (-LEVELS)) or (ABOVE and (selfpos.z - player.z) >= 0 and (selfpos.z - player.z) <= LEVELS)
				if var then
					Self.Logout()
					logoutTime = os.clock()
					LAST_PLAYER = player.name
					LOGOUT_TIME = os.date("%X")
					wait(500, 1800)
	                break -- break loop
	            end
	        end
	    end
	else
        if RELOGIN.enabled then
        	if os.clock() - printfTime > 1 then 
	        	if LAST_PLAYER ~= "" then
	        		printf("[" .. LOGOUT_TIME .. "] Successfully logout due a player detected [" .. LAST_PLAYER .. "] Relogin for " .. math.floor((RELOGIN.delay * 60) - (os.clock() - logoutTime)) .. "s.")
	        	else
	        		printf("You lost connection to game.")	
	        	end	
	        	printfTime = os.clock()
	        end	
	        if os.clock() - logoutTime > (60 * RELOGIN.delay) then
	            Rifbot.PressKey(13, 2000)  -- press enter key 
	        end
	    else
	    	if logoutTime ~= -1 then
	    		if LAST_PLAYER ~= "" then
	        		printf("[" .. LOGOUT_TIME .. "] Successfully logout due a player detected [" .. LAST_PLAYER .. "] Relogin is disabled.")
	        	else
	        		printf("You lost connection to game. Relogin is disabled.")	
	        	end	
	        	logoutTime = -1
	    	end       
	    end                
	end												
end)
