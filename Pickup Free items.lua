--[[
    Script Name:        Pickup Free items
    Description:        Pickup free items around your character to first slot in any opened backpack.
    Author:             Ascer - example
]]

local FREE_ITEMS = {2874, 3031, 3447}     -- IDs of items to pickup

-- DON'T EDIT BELOW

Module.New("Pickup Free items", function ()

	if Self.isConnected() then
		
		-- load self pos.
		local pos = Self.Position()

		-- in range for 1 sqm
		for x = -1, 1 do

			for y = -1 , 1 do
				
				-- load map
				local map = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)

				-- when we found item
				if table.find(FREE_ITEMS, map.id) then

					-- Pickup item
					Self.PickupItem(pos.x + x, pos.y + y, pos.z, map.id, map.count, Container.GetWithEmptySlots(nr), 0, 0)

					-- break loop
					break

				end	

			end
			
		end		
	end

end) 
