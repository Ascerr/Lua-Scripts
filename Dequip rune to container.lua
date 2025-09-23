--[[
    Script Name:        Dequip rune to container
    Description:        When you create rune, dequip it to specific container index.
    Author:             Ascer - example
]]


local config = {
	rune = 3031,								-- dequip this rune id from left hand.
	container_index = 0,						-- to container index: 0 - first opened.
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Dequip rune to container", function()
	if Self.isConnected() then
		local weapon = Self.Weapon()
		if weapon.id == config.rune then
			local cont = Container.getInfo(config.container_index)
			local slotTo = 19
			if table.count(cont) > 0 then
				slotTo = cont.amount
			end	
			Self.DequipItem(SLOT_WEAPON, config.container_index, slotTo, 500)
		end	
	end	
end)