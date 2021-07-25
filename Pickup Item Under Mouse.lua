--[[
    Script Name:        Pickup Item Under Mouse
    Description:        Pickup items under mouse cursor execute when shortkey pressed.
    Required:			Script will execute once then unload. You need to set it on shortkey: EXECUTE pickup item under mouse  
    Author:             Ascer - example
]]

local PICKUP_ITEMS = {3031, 3492, 2148}    -- set id items to pickup
local PICKUP_INDEX = -1				 -- which backpack to pickup items. if you want any with empty slots then set -1 

-- DON'T EDIT BELOW

function mousePick()
	local mouse = Rifbot.GetGroundPosUnderMouse()
	local item = Map.GetTopMoveItem(mouse.x, mouse.y, mouse.z)
	if table.find(PICKUP_ITEMS, item.id) then
		local backpack = PICKUP_INDEX
		if PICKUP_INDEX == (-1) then
			backpack = Container.GetWithEmptySlots()
			if backpack == (-1) then 
				backpack = 0
			end
		end		  
		Self.PickupItem(mouse.x, mouse.y, mouse.z, item.id, item.count, backpack, 0, 0)
	end
end	

-- call function
mousePick()
