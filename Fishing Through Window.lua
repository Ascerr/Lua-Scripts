--[[
    Script Name: 		Fishing Through Window
    Description: 		Use fishing only in specific places.
    Author: 			Ascer - example
]]

local config = {
	delay = {1000, 1500},	-- miliseconds use fishing rod time
	rod = 3483,				-- fishinf rod id
	minCap = 10,			-- dont fishing if cap below
	positions = {{-5, 0}, {-6, 0}, {-7, 0}, {-5, 1}, {-6, 1}, {-7, 1}, {-5, -1}, {-6, -1}, {-7, -1}, {5, 0}, {6, 0}, {7, 0}, {5, -1}, {6, -1}, {7, -1}, {5, 1}, {6, 1}, {7, 1}}	-- where to fishing. Your pos in game is {0, 0}
}

-- DONT'T EDIT BELOW THIS LINE 

local selfloc, fishingPos = Self.Position(), {}

Module.New("Fishing Through Window", function (mod)
	if Self.isConnected() then
		local pos = Self.Position()
		local cap = Self.Capity()

		-- set random tile to fish.
		if table.count(config.positions) > 0 and cap > config.minCap then
			local tile = config.positions[math.random(1, table.count(config.positions))] 
			Self.UseItemWithGround(config.rod, pos.x + tile[1], pos.y + tile[2], pos.z, 100) -- use fishing rod.
		end	

	end	
	mod:Delay(config.delay[1], config.delay[2]) -- set random delay
end)


