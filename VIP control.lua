--[[
    Script Name: 		VIP control
    Description: 		Check up for buddies from vip list and logout when all are offline. Edit: 2019-05-14 added relogin.
    Author: 			Ascer - example
]]

local LIST = {"def character", "friend"} 	-- list of players from vip list to search.
local RELOGIN = {enabled = true, delay = 5} -- relogin to game when player detected or lost connection. enabled = true/false, delay = 6 min or immediately when lost connection

-- DONT'T EDIT BELOW THIS LINE 

local list, logoutTime, printfTime, rec = table.lower(LIST), 0, 0, false


Module.New("VIP control", function ()
	
	-- when we are connected.
	if Self.isConnected() then

		-- when rec is true then wait to avoid multiple logouts.
		if rec then

			-- wait 5000ms
			wait(5000)

			-- set rec false
			rec = false

		end	
		
		-- check if vip is online
		if not VIP.isOnline(list) then
			
			-- logout
			Self.Logout()
			
			-- set message to Rifbot console
			printf("Logged out due a no players in vip list.")

			-- set time.
			logoutTime = os.clock()

		end

	else

		-- when relogin is enabled
		if RELOGIN.enabled  then
        	
			-- check for time 
	        if os.clock() - logoutTime > (60 * RELOGIN.delay) then

	        	-- press enter key
	            Rifbot.PressKey(13, 3000)

	            -- set status for rec.
	            rec = true

	        else

		        -- check for time to avoid spam
	        	if os.clock() - printfTime > 1 then 

	        		-- set message to console
			        printf("Successfully logged out due a VIP offline. Relogin for " .. math.floor((RELOGIN.delay * 60) - (os.clock() - logoutTime)) .. "s.")
		        	
		        	-- set new time
		        	printfTime = os.clock()

		        end	

	        end

	    end 

	end	

end)
