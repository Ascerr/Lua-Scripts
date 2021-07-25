--[[
    Script Name:        Pickup MF around you
    Description:        Pickup mana fluid around your character to empty backpack.
    Author:             Ascer - example
]]

local MF_ID =  2874    --  set 2006 for old tibia

-- DON'T EDIT BELOW

Module.New("Pickup MF around you", function (mod)

	if Self.isConnected() then
		
		-- load self pos
		local pos = Self.Position()

		-- for loop
		for x = -1, 1 do
			
			for y = -1, 1 do

				-- load item
				local item = Map.GetTopMoveItem(pos.x+x, pos.y+y, pos.z)

				-- when mf id
				if item.id == MF_ID then
					
					-- Pickup item
					Self.PickupItem(pos.x+x, pos.y+y, pos.z, item.id, 1, Container.GetWithEmptySlots(), 0, 300)

					-- destroy loop
					break

				end	

			end
			
		end	

	end		

	-- set module delay
	mod:Delay(300)

end) 
