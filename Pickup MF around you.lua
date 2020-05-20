--[[
    Script Name:        Pickup MF around you
    Description:        Pickup mana fluid around your character to container.index 0 slot 0
    Author:             Ascer - example
]]

local MF_ID = 2874     -- set 2006 for old tibia

-- DON'T EDIT BELOW

Module.New("Pickup MF around you", function (mod)

	if Self.isConnected() then
		
		local map = Map.getArea(1) -- load map with 1 sqm range
		for i, square in pairs(map) do
			local sqareItems = square.items
			for j, item in pairs(sqareItems) do
				if item.id == MF_ID then
					
					-- Pickup item
					Self.PickupItem(square.x, square.y, square.z, item.id, 1, 0, 0, 300)

					break
	
				end
			end			
		end
	end
	mod:Delay(300, 500)	
end) 
