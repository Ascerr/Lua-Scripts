--[[
    Script Name: 		Use Training Wand with Dummy after login
    Description: 		When you lost connection, character will use training wand with dummy from backpack or ground
    Author: 			Ascer - example
]]

local config = {
	useFromBackpack = {enabled = true, id = 1234},		-- true/false use training item direct from backpack. if false use from ground: wand = {x, y, z} // id - trainign weapon
	dummy = {x = 32358, y = 32235, z = 6},				-- position of training dummy
	wand = {x = 32358, y = 32234, z = 6}				-- training wand position on ground {required only id useFromBackpack = false}.
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Use Training Wand with Dummy after login", function ()
	if Self.isConnected() then
		if useWand and Container.Amount() > 0 then
			wait(1000)
			if config.useFromBackpack.enabled then
				Self.UseItemWithGround(config.useFromBackpack.id, config.dummy.x, config.dummy.y, config.dummy.z, 0)
			else	
				Map.UseItemWithGround(config.wand.x, config.wand.y, config.wand.z, config.dummy.x, config.dummy.y, config.dummy.z, 0)
			end
			useWand = false
		end	
	else
		useWand = true
	end	
end)
