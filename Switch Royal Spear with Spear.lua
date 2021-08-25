--[[
    Script Name:        Switch Royal Spear with Spear
    Description:        When you hunting and drop royal spears then wear it instead of standard spear (infinite)
    Required:			Adding to looter Royal Spears.
    Author:             Ascer - example
]]

local config = {
	spear = 3277,			-- id of basic spear
	royal_spear = 7037		-- id of royal spear
}

-- DON'T EDIT BELOW

Module.New("Switch Royal Spear with Spear", function ()

	-- when connected
	if Self.isConnected() then
		
		-- load slot weapon
		local weapon = Self.Weapon()

		-- load amount of royal spears
		local count = Self.ItemCount(config.royal_spear)

		-- when we have royal spears in containers.
		if count > 0 then

			-- when current weapon is spear
			if weapon.id == config.spear then

				-- dequip spear to first empty container
				Self.DequipItem(SLOT_WEAPON)

			else
				
				-- equip royal spears.
				Self.EquipItem(SLOT_WEAPON, config.royal_spear, count, 300)

			end	

		else
			
			-- when no weapon.
			if not table.find({config.spear, config.royal_spear}, weapon.id) then

				-- wear basic spear qt = 1
				Self.EquipItem(SLOT_WEAPON, config.spear, 1, 300)

			end	

		end	
		
	end

end) 