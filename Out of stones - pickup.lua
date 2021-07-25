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

			-- load position
			local pos = Self.Position()
			
			-- search stones on 1 sqm range
			for x = -1, 1 do

				for y = -1, 1 do

					-- load map item
					local item = Map.GetTopMoveItem(pos.x+x, pos.y+y, pos.z)

					-- if id is equal to id small stone
					if item.id == SMALL_STONE then
						
						-- Pickup item
						Self.EquipItemFromGround(hand, pos.x+x, pos.y+y, pos.z, item.id, item.count, 1000)

						-- end loop
						break
		
					end

				end	
			
			end

		end

	end	

	-- execution module delay in ms
	mod:Delay(1000)	

end) 
