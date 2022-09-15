--[[
    Script Name:        Drop Fish and Burst Arrow
    Description:        Drop fish and burst arrows when there is above 10 example.
    Author:             Ascer - example
]]

local config = {
	fish = {id = 2667, above = 10, pos = {x = 32344, y = 32224, z = 8}},	-- fish id, drop when amount above, pos x, y, z on map where to drop.
	burst = {id = 3449, above = 10, pos = {x = 32344, y = 32225, z = 8}}
}


-- DON'T EDIT BELOW THIS LINE

Module.New("Drop Fish and Burst Arrow", function()
	
	-- when connected
	if Self.isConnected() then

		-- load amount of burst arrows
		local arrows = Self.ItemCount(config.burst.id)

		-- when amount is above limit.
		if arrows > config.burst.above then

			-- we drop 100 this mean when will below this value drop full stack.
			Self.DropItem(config.burst.pos.x, config.burst.pos.y, config.burst.pos.z, config.burst.id, 100) 

		end	

		-- load amount of fish
		local roach = Self.ItemCount(config.fish.id)

		-- when amount is above limit.
		if roach > config.fish.above then

			-- we drop 100 this mean when will below this value drop full stack.
			Self.DropItem(config.fish.pos.x, config.fish.pos.y, config.fish.pos.z, config.fish.id, 100) 

		end	

	end

	-- set delay
	mod:Delay(400, 800)

end)