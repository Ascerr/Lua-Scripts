--[[
    Script Name: 		Mouse Click Reconnect Nostalrius
    Description: 		Logout when character detected on multiple floors or VIP detected in list.. (extra add avoid relogin if player detected short after login)
    Author: 			Ascer - example
]]

local MOUSECLICK = {x = 700, y = 500}		-- where to click before pressing Enter to relogin. 
local DELAY = 5								-- time every we click mouse in seconds

-- DONT EDIT BELOW THIS LINE

local clickTime = 0

Module.New("Mouse Click Reconnect Nostalrius", function()
	
	-- when not connected
	if not Self.isConnected() then

		-- when delay is valid
 		if os.clock() - clickTime >= DELAY then

			-- click mouse (right)
			Rifbot.MouseClick(MOUSECLICK.x, MOUSECLICK.y, 1)

			-- update time
			clickTime = os.clock()	

		end	

	else	

		-- we are online reset time
		clickTime = 0

	end	

end)
