--[[
    Script Name: 		Login to game at time.
    Description: 		When specific time from computer login to server.
    Author: 			Ascer - example
]]

local LOGIN_AT = "09:55" 	-- login at time.


-- DONT'T EDIT BELOW THIS LINE
local login = false

Module.New("Login to game at time", function ()
	
	-- get time 
	local h, min = os.date("%H"), os.date("%M")

	-- when time is fine
	if (h .. ":" .. min) == LOGIN_AT then

		-- set flag true
		login = true

	end

	-- when login
	if login then

		-- when not connected
		if Self.isConnected() then

			-- press enter key
	        Rifbot.PressKey(13, 3000)

		end	

	end	
	
end)	

