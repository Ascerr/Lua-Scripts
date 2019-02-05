--[[
    Script Name: 		Small Stone Picker
    Description: 		Pickup Small stones when amount on ground reach X. Range 1sqm
    Author: 			Ascer - example
]]


-- LOCAL CONFIG:

local MAIN_DELAY = {1500, 2700}		-- Random delay in miliseconds between actions.
local PICKUP_ID = 1781				-- Small Stone ID, 3277 -> spear id if someone need.
local PICKUP_AMOUNT = {1, 6}		-- Random amount. We don't wanna pickup every single stone.
local HAND = "right"				-- Hand to pickup, type: "left" for right hand.
local ITEM_WEIGHT = 3.6				-- Weight in oz. single stone to calculate real pickup amount 20 for spear.
local RANDOM_EACH_LOOP = true		-- Calculate random items to pickup each loop = true or just once until reach ground amount then next = false

-- DON'T EDIT BELOW THIS LINE

local randomAmount = -1

Module.New("Small Stone Picker", function (mod)
	if Self.isConnected() then
		
		local cap = Self.Capity()
		local hand = SLOT_WEAPON
		
		if string.lower(HAND) == "left" then -- get hand
			hand = SLOT_SHIELD
		end

		if (randomAmount < 0 and not RANDOM_EACH_LOOP) or RANDOM_EACH_LOOP then -- set random amount
			randomAmount = math.random(PICKUP_AMOUNT[1], PICKUP_AMOUNT[2])
		end	

		if (cap - 1) > ITEM_WEIGHT then
			local map = Map.getArea(1) -- load map with 1 sqm range
			for i, square in pairs(map) do
				local sqareItems = square.items
				for j, item in pairs(sqareItems) do
					if item.id == PICKUP_ID then
						if item.count < randomAmount then
							break -- end loop cuz no enough items
						else
							local maxPickup = math.floor((cap - 1)/ITEM_WEIGHT) -- calculate amount to pickup
							local toPickup = item.count
							if maxPickup < item.count then
								toPickup = maxPickup
							end

							-- Pickup item
							Self.EquipItemFromGround(hand, square.x, square.y, square.z, item.id, toPickup)

							-- set random to -1
							randomAmount = -1

							break
						end	
					end
				end			
			end
		end
	end		
	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2])
end) 