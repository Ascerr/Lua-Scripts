--[[
    Script Name: 		Login to game at time.
    Description: 		When specific time from computer login to server.
    Author: 			Ascer - example
]]

local LOGIN_AT = {"11:16", "11:19"} 	-- login at time, possible many specific times.
local STAY_ONLINE_FOR = {
	enabled = false,					-- enabled true/false stay online for specific time
	seconds = 120						-- amount of seconds beeing online (minimum is 61)
}

-- DONT'T EDIT BELOW THIS LINE
local login, loggedTime = false, 0

Module.New("Login to game at time", function ()
	
	-- get time 
	local h, min = os.date("%H"), os.date("%M")

	-- when not login
	if not login then

		-- inside loop check for possible times
		for i = 1, #LOGIN_AT do

			-- when time is fine
			if (h .. ":" .. min) == LOGIN_AT[i] then

				-- set flag true
				login = true

				-- destroy loop
				break

			end	

		end

	else		

		-- when not connected
		if not Self.isConnected() then

			-- press enter key
	        Rifbot.PressKey(13, 3000)

	        -- set last loggedTime
	        loggedTime = os.clock()

	    else
	    
	    	-- when is enabled stay for while
	    	if STAY_ONLINE_FOR.enabled then

	    		-- when time is fine
	    		if os.clock() - loggedTime > STAY_ONLINE_FOR.seconds then

	    			-- logout if not pz
	    			if not Self.isInFight() then 

	    				Self.Logout() 

	    				login = false

	    			end

	    		end

	    	else		

	    		-- disable login param
	    		login = false

	    	end	

		end	

	end	
	
end)	

