--[[
    Script Name: 		Multifloor Player Logout
    Description: 		Logout when character detected on multiple floors or VIP detected in list..
    Author: 			Ascer - example
]]


local FRIENDS = {"friend1", "friend2"} 		-- list of friends
local VIP_LIST = {"enemy1", "enemy2"}    	-- enter players here separated with comma
local BELOW = true							-- check for players below you
local ABOVE = false							-- check for player above you
local LEVELS = 1							-- search for one floor above or below / limit is 2 / do not check floors below on level 7
local RELOGIN = {enabled = true, delay = 6} -- relogin to game when player detected or lost connection. enabled = true/false, delay = 6 min or immediately when lost connection
local NO_BLANKS = {							-- when no blank runes logout - true/false, castSpell - true/false, spell - what cast if no blanks.
	logout = true, 
	castSpell = false, 
	spell = "exura"
}				


-- DON'T EDIT BELOW THIS LINE

FRIENDS = table.lower(FRIENDS) -- convert table to lower strings.
logoutTime, printfTime, LOGOUT_TIME, LAST_PLAYER, LOGOUT_REASON, noBlanks = 0, 0, "", "", "", false

Module.New("Multifloor + VIP Logout", function (mod)
	if Self.isConnected() then
		LAST_PLAYER = ""
		logoutTime = 0
		noBlanks = false -- reset no balnks proxy state.
		LOGOUT_REASON = "game issue"
		local selfpos = Self.Position()
		for i, player in pairs(Creature.iPlayers(7, true)) do  -- get only above and below
			if not table.find(FRIENDS, string.lower(player.name)) then
				local var = (BELOW and (selfpos.z - player.z) <= 0 and (selfpos.z - player.z) >= (-LEVELS)) or (ABOVE and (selfpos.z - player.z) >= 0 and (selfpos.z - player.z) <= LEVELS)
				if var then
					Self.Logout()
					logoutTime = os.clock()
					LOGOUT_REASON = "player detected"
					LAST_PLAYER = player.name
					LOGOUT_TIME = os.date("%X")
					wait(1500, 2800)
	                break -- break loop
	            end
	        end
	    end
		if VIP.isOnline(VIP_LIST) then
            Self.Logout()
            LOGOUT_REASON = "vip detected"
            logoutTime = os.clock()
            LOGOUT_TIME = os.date("%X")
            wait(1500, 2800)
        end
        if string.instr(Proxy.ErrorGetLastMessage(), "magic item to cast") then
        	if NO_BLANKS.logout then
        		noBlanks = true
        		Self.Logout()
        		wait(1500, 2800)
        		printf("[" .. os.date("%X") .. "] Successfully logged out due a no blank runes.")
        	elseif NO_BLANKS.castSpell then
        		Self.CastSpell(NO_BLANKS.spell)	
        		printf("No more blank runes using " .. NO_BLANKS.spell .. " to burn mana.")	
        	end
        	Proxy.ErrorClearMessage() -- we need to clear message manually.	
        end		
	else
        if RELOGIN.enabled and ((not NO_BLANKS.logout) or (NO_BLANKS.logout and not noBlanks))  then
        	if os.clock() - printfTime > 1 then 
	        	local log = ""
	        	if LOGOUT_REASON == "player detected" then
	        		log = LOGOUT_REASON .. " [" .. LAST_PLAYER .. "]"
		        elseif LOGOUT_REASON == "vip detected" then		
		        	log = LOGOUT_REASON
		        else
		        	log = LOGOUT_REASON
		        end		
		        printf("[" .. LOGOUT_TIME .. "] Successfully logged out due a " .. log .. " Relogin for " .. math.floor((RELOGIN.delay * 60) - (os.clock() - logoutTime)) .. "s.")
	        	printfTime = os.clock()
	        end	
	        if os.clock() - logoutTime > (60 * RELOGIN.delay) then
	            Rifbot.PressKey(13, 2000)  -- press enter key 
	        end

	    else
	    	if os.clock() - printfTime > 1 and not noBlanks then 
	    		printf("You have been logged out due a " .. LOGOUT_REASON .. ". Relogin is disabled.")
	    		printfTime = os.clock()
	    	end	       
	    end                
	end												
end)
