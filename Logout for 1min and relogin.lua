--[[
    Script Name:        Logout for 1min and relogin
    Description:        Run this script from walker the best way: lua: Rifbot.ExecuteScript("Logout for 1min and relogin")
    Author:             Ascer - example
]]

local LOGOUT_SECONDS = 60 -- how many seconds stay loggout out.

-- DON'T EDIT BELOW THIS LINE

local startT, login = 0, false
Module.New("Logout for 1min and relogin", function()
	if Self.isConnected() then
		if not login then
			Self.Logout()
			startT = os.clock()
		else
			Rifbot.KillScript(selfScriptName)
		end	
	else	
		if os.clock() - startT >= LOGOUT_SECONDS then
			Rifbot.PressKey(13, 3000)
			login = true
		end	
	end	
end)
