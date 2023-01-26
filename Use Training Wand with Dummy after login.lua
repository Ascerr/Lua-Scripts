--[[
    Script Name: 		Use Training Wand with Dummy after login
    Description: 		When you lost connection, character will use training wand with dummy (wand must be in container)
    Author: 			Ascer - example
]]

local config = {
	wand = 6014,								-- training wand id.
	dummy = {x = 32359, y = 32235, z = 6}		-- position of training dummy
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Use Training Wand with Dummy after login", function ()
	if Self.isConnected() then
		if useWand then
			wait(1000)
			Self.UseItemWithGround(config.wand, config.dummy.x, config.dummy.y, config.dummy.z, 0)
			useWand = false
		end	
	else
		useWand = true
	end	
end)
