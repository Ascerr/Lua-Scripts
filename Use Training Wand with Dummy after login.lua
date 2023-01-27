--[[
    Script Name: 		Use Training Wand with Dummy after login
    Description: 		When you lost connection, character will use training wand with dummy (wand must be on ground)
    Author: 			Ascer - example
]]

local config = {
	wand = {x = 32358, y = 32234, z = 6},	-- training wand position on ground.
	dummy = {x = 32359, y = 32235, z = 6}	-- position of training dummy
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Use Training Wand with Dummy after login", function ()
	if Self.isConnected() then
		if useWand and Container.Amount() > 0 then
			wait(1000)
			Map.UseItemWithGround(config.wand.x, config.wand.y, config.wand.z, config.dummy.x, config.dummy.y, config.dummy.z, 0)
			useWand = false
		end	
	else
		useWand = true
	end	
end)
