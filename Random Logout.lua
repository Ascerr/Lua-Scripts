--[[
    Script Name: 		Random Logout
    Description: 		Logout when character detected on multiple floors + random logout for x time to avoid beeing hunted due long runemaking.
    Author: 			Ascer - example
]]

local FRIENDS = {"friend1", "friend2"} 		-- list of friends
local BELOW = true							-- check for players below you
local ABOVE = false							-- check for player above you
local LEVELS = 0							-- search 0 {your floor} or 1 one floor above or below / limit is 2 / do not check floors below on level 7
local RELOGIN = {enabled = true, delay = 6} -- relogin to game when player detected or lost connection. enabled = true/false, delay = 6 min or immediately when lost connection
local RANDOM_LOGOUT = {
	every = {60, 90}, 						-- minutes random(60, 90) we will logout of game.
	due = {5, 7}							-- minutes random(5, 7) we will wait before relogin to game
}

-- DON'T EDIT BELOW THIS LINE

FRIENDS = table.lower(FRIENDS) -- convert table to lower strings.
logoutTime, printfTime, LOGOUT_TIME, LAST_PLAYER, randomEveryDelay, randomDueDelay, randomLogout, randomEveryTime, randomDueTime = 0, 0, "", "", 0, 0, false, os.time(), 0

Module.New("Random Logout", function (mod)
	
	if Self.isConnected() then
		LAST_PLAYER = ""
		logoutTime = 0
		local selfId = Self.ID()
		local selfpos = Self.Position()
		for i, player in pairs(Creature.getCreatures()) do  -- get only above and below
			if not table.find(FRIENDS, string.lower(player.name)) and Creature.isPlayer(player) and player.id ~= selfId then
				local var = (BELOW and (selfpos.z - player.z) <= 0 and (selfpos.z - player.z) >= (-LEVELS)) or (ABOVE and (selfpos.z - player.z) >= 0 and (selfpos.z - player.z) <= LEVELS)
				if var then
					Self.Logout()
					logoutTime = os.time()
					LAST_PLAYER = player.name
					LOGOUT_TIME = os.date("%X")
					wait(500, 1800)
	                break -- break loop
	            end
	        end
	    end

	    if randomEveryDelay <= 0 then
	    	randomEveryDelay = math.random(RANDOM_LOGOUT.every[1], RANDOM_LOGOUT.every[2]) -- set new random values for random logout
	    	randomDueDelay = math.random(RANDOM_LOGOUT.due[1], RANDOM_LOGOUT.due[2])
	    	randomLogout = false
	    else
	    	if os.time() - randomEveryTime > (60 * randomEveryDelay) then
	    		randomDueTime = os.time()
	    		randomLogout = true
	    		LOGOUT_TIME = os.date("%X")
	    		Self.Logout() -- logout due a reach random delay
	    	end
	    end

	else

        if RELOGIN.enabled or randomLogout then
        	if os.time() - printfTime > 1 then 
	        	if randomLogout then
	        		printf("[" .. LOGOUT_TIME .. "] Successfully logout due a random delay [" .. randomEveryDelay .. "] Relogin for " .. math.floor((randomDueDelay * 60) - (os.time() - randomDueTime)) .. "s.")
	        	elseif LAST_PLAYER ~= "" then
	        		printf("[" .. LOGOUT_TIME .. "] Successfully logout due a player detected [" .. LAST_PLAYER .. "] Relogin for " .. math.floor((RELOGIN.delay * 60) - (os.time() - logoutTime)) .. "s.")
	        	else
	        		printf("You lost connection to game.")	
	        	end	
	        	printfTime = os.time()
	        end	
	        if randomLogout then
	        	if os.time() - randomDueTime > (60 * randomDueDelay) then
	            	Rifbot.PressKey(13, 2000)  -- press enter key 
	            	randomEveryDelay = 0
	            	randomEveryTime = os.time()
	        	end
	        else
	        	if os.time() - logoutTime > (60 * RELOGIN.delay) then
	            	Rifbot.PressKey(13, 2000)  -- press enter key 
	            	randomEveryDelay = 0
	            	randomEveryTime = os.time()
	        	end
	        end	   
	    end                
	end	

end)
