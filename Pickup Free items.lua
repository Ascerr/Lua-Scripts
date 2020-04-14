--[[
    Script Name:        Pickup Free items
    Description:        Pickup mana fluid around your character to container.index 0 slot 0
    Author:             Ascer - example
]]

local FREE_ITEMS = {2874, 3031}     -- IDs of items to pickup

-- DON'T EDIT BELOW

Module.New("Pickup Free items", function ()

	if Self.isConnected() then
		
		local map = Map.getArea(1) -- load map with 1 sqm range
		for i, square in pairs(map) do
			local sqareItems = square.items
			for j, item in pairs(sqareItems) do
				if table.find(FREE_ITEMS, item.id) then
					
					-- Pickup item
					Self.PickupItem(square.x, square.y, square.z, item.id, item.count, 0, 0)

					break
	
				end
			end			
		end
	end		
end) 
