--[[
    Script Name: 		Stop Walker and Logout after Time
    Description: 		When you botting example 60 min and want to stop cavebot and logout when no fight mode use this lua. 
    Author: 			Ascer - example
]]

local config = {
	session_time = 60	-- time in minutes to to end botting and logout.	
}


-- DON'T EDIT BELOW THIS LINE

local setTime = os.clock()

Module.New("Stop Walker and Logout after Time", function ()
	
	-- when connected
	if Self.isConnected() then

		-- when time is above limit.
		if os.clock() - setTime >= config.session_time * 60 then

			-- disable walker and looter.
			if Walker.isEnabled() then Walker.Enabled(false) end
			if Looter.isEnabled() then Looter.Enabled(false) end

			-- when no fight mode then logout.
			if not Self.isInFight() then

				-- logout
				Self.Logout()

				wait(1000)

				-- show log
				print("Logout due session time end: " .. config.session_time)

			end	

		end	

	end	

end)
