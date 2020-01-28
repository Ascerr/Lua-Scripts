--[[
    Script Name: 		Logout at time
    Description: 		Logout character between specific time example 09:55 and 10:00. Later login.
    Author: 			Ascer - example
]]

local LOGOUT_TIME = "09:55" 	-- logout when this time
local LOGIN_FOR = 7 			-- minutes after we login again.

-- DONT'T EDIT BELOW THIS LINE

local logout, login, logoutTime = false, false, 0

Module.New("Logout at time", function ()
	
	-- get time 
	local h, min = os.date("%H"), os.date("%M")

	-- when time is fine and not variable contains true
	if (h .. ":" .. min) == LOGOUT_TIME and not logout and not login then

		-- when im connected.
		if Self.isConnected() then

			-- set variable logout true
			logout = true

		end	

	end
	
	-- when variable logout contains true
	if logout then

		-- if we are conneced
		if Self.isConnected() then

			-- send logout action
			Self.Logout()

		else
			
			-- set logout false
			logout = false

			-- set logout time
			logoutTime = os.time()

			-- set variable login true
			login = true

			-- Dodaj msg do consoli.
			printf("Successfuly logged out due time " .. os.date("%X") .. ", relogin for " .. LOGIN_FOR .. " mins.")

		end

	end	

	-- if param login contains true
	if login then

		-- if we are not conneced
		if not Self.isConnected() then

			-- when time is ok
			if os.time() - logoutTime >= (60 * LOGIN_FOR) then

				-- login to game standard option sending key enter, for classicTibia use func: classicTibiaRelogin()
				Rifbot.PressKey(13, 2000)

			end

		else
			
			-- reset params
			logoutTime = 0
			login = false
			logout = false

		end		

	end		

end)	