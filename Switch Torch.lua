--[[
    Script Name:        Switch Torch
    Description:        Throw to ground burnt down torch, wear brand new torch and light up.
    Author:             Ascer - example
]]

local BURNT_DOWN_TORCH = 2926			-- ID of already used torch without light.
local BRAND_NEW_TORCH = 2920			-- ID of brand new never used torch.

-- DON'T EDIT BELOW THIS LINE

Module.New("Switch Torch", function()
	if Self.isConnected() then
		local ammoSlot = Self.Ammo()
		if ammoSlot.id == BURNT_DOWN_TORCH then
			local me = Self.Position()
			Self.DropItem(me.x, me.y, me.z, BURNT_DOWN_TORCH, 1, 500)
		elseif ammoSlot.id == 0 then
			Self.EquipItem(SLOT_AMMO, BRAND_NEW_TORCH, 1, 500)
		elseif ammoSlot.id == BRAND_NEW_TORCH then
			Self.UseItemFromEquipment(SLOT_AMMO, 500)		
		end	
	end	
end)