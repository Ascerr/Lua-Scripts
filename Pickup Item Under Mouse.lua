--[[
    Script Name:        Pickup Item Under Mouse
    Description:        Pickup items under mouse cursor execute when shortkey pressed.
    Required:			Script will execute once then unload. You need to set it on shortkey: EXECUTE pickup item under mouse  
    Author:             Ascer - example
]]

local PICKUP_ITEMS = {3031, 3492}    -- set id items to pickup
local PICKUP_INDEX = -1				 -- which backpack to pickup items. if you want any with empty slots then set -1 

-- DON'T EDIT BELOW

function mousePick()
	local map = Map.getArea(7)
	local mouse = Rifbot.GetGroundPosUnderMouse()
	for i, square in pairs(map) do
		if square.x == mouse.x and square.y == mouse.y and square.z == mouse.z then
			local sqareItems = square.items
			for j, item in pairs(sqareItems) do
				if table.find(PICKUP_ITEMS, item.id) then
					local backpack = PICKUP_INDEX
					if PICKUP_INDEX == (-1) then
						backpack = Container.GetWithEmptySlots()
						if backpack == (-1) then 
							backpack = 0
						end
					end		  
					Self.PickupItem(square.x, square.y, square.z, item.id, item.count, backpack, 0, 0)
				end
			end
			return false
		end				
	end
end	

-- call function
mousePick()