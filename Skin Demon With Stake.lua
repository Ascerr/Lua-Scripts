--[[
    Script Name:        Skin Demon With Stake
    Description:        Use blessed wooden stake on demon with range 1
    Author:             Ascer - example
]]

local BLESSED_WOODEN_STAKE = 5942			-- id of wooden stake item
local CROPSES = {1234,1234}					-- table with copses ids to use with

-- DON'T EDIT BELOW

Module.New("Skin Demon With Stake", function (mod)

	-- when online
	if Self.isConnected() then
		
		-- load map with 1 sqm range
		local map = Map.getArea(1) 
		
		-- in loop
		for i, square in pairs(map) do
			
			-- load sqm items
			local sqareItems = square.items
			
			-- in loop
			for j, item in pairs(sqareItems) do
				
				-- when copse found
				if table.find(CROPSES, item.id) then
					
					-- use stake
					Self.UseItemWithGround(BLESSED_WOODEN_STAKE, square.x, square.y, square.z)

					-- break loop
					break
	
				end

			end	

		end

	end	

	-- mod execution delay
	mod:Delay(1000)	

end) 