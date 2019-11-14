--[[
    Script Name: 		Pickup Blanks Drop GFBs
    Description: 		Character will pickup one single rune to hand slot from backpack (this could lay on ground or smth). 
    				Later throw created rune example GFB to house spot.
    Author: 			Ascer - example
]]

local THROW_HOUSE_SPOT = {32316, 32254, 6} -- position {x,y,z} where to thrown created already rune.
local BLANK_RUNE_ID = 3147 -- id of blank rune
local HAND = "left" -- put to hand left or right.

-- DON'T EDIT BELOW THIS LINE

-- detect what hand to pickup blanks
if HAND == "left" then

	-- left side of client
	toHand = SLOT_WEAPON

else
    
    -- right side of client
	toHand = SLOT_SHIELD

end		


Module.New("Pickup Blanks Drop GFBs", function (mod)
	
	-- load hand
	local slot = selfGetEquipmentSlot(toHand)

	-- if the slot id is different than blank rune.
	if slot.id ~= 0 and slot.id ~= BLANK_RUNE_ID then

		-- Throw rune to ground pos
		Container.MoveItemFromEquipmentToGround(toHand, THROW_HOUSE_SPOT[1], THROW_HOUSE_SPOT[2], THROW_HOUSE_SPOT[3], slot.id, slot.count)

	-- when slot is empty.	
	elseif 	slot.id == 0 then

		-- equip blank rune to hand
		Self.EquipItem(toHand, BLANK_RUNE_ID, 1)

	end	

	-- execution random time
	mod:Delay(200, 500)

end) 
