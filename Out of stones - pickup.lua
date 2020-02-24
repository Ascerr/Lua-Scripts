--[[
    Script Name:        Out of stones - pickup
    Description:        Pickup small stones to hand only if this inventory slot is empty.
    Author:             Ascer - example
]]

local SMALL_STONE = 1781     -- id of small stone/ spear 3277
local HAND = "left"	   -- where to pickup stones "left" or "right" monitor side

-- DON'T EDIT BELOW

Module.New("Out of stones - pickup", function (mod)

	-- if we are connected
	if Self.isConnected() then
		
		-- set hand to slot weapon "left" monitor side
		local hand = SLOT_WEAPON
		
		-- set new hand if need
		if string.lower(HAND) == "right" then 
			hand = SLOT_SHIELD
		end

		-- only if hand slot is empty 
		if selfGetEquipmentSlot(hand).id == 0 then

			-- load map with 1 sqm range
			local map = Map.getArea(1)
			
			-- for each square on map 
			for i, square in pairs(map) do
				
				-- load items on square
				local sqareItems = square.items
				
				-- for items on square
				for j, item in pairs(sqareItems) do
					
					-- if id is equal to id small stone
					if item.id == SMALL_STONE then
						
						-- Pickup item
						Self.EquipItemFromGround(hand, square.x, square.y, square.z, item.id, item.count, 1000)

						-- end loop
						break
		
					end

				end	

			end

		end

	end	

	-- execution module delay in ms
	mod:Delay(2000)	

end) 