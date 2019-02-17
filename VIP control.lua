--[[
    Script Name: 		VIP control
    Description: 		Check up for buddies from vip list and logout when all are offline.
    Author: 			Ascer - example
]]

local LIST = {"mustafa", "rps rps oo"} 	-- list of players from vip list to search.

-- DONT'T EDIT BELOW THIS LINE 

list = table.lower(LIST)

Module.New("VIP control", function ()
	if Self.isConnected() then
		if not VIP.isOnline(list) then
			Self.Logout()
			printf("Logged out due a no players in vip list.")
		end
	end		
end)