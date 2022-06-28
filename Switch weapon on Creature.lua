--[[
    Script Name: 		Switch weapon on Creature
    Description: 		Change one hand weapon to other depend on creatures name. 
    Author: 			Ascer - example
]]

local config = {
	first = 3286,						-- id of first default weapon (wear it also when no target) 
	second = 3268,						-- id of second weapon we will wear if attacking monsters from list below.
	monsters = {"rotworm", "spider"}	-- list of monsters to wear second weapon.
}


-- DON'T EDIT BELOW THIS LINE

-- change name to lower names
config.monsters = table.lower(config.monsters)

Module.New("Switch weapon on Creature", function ()
	
	-- when connected
	if Self.isConnected() then

		-- load target id
		local target = Self.TargetID()

		-- when target is
		if target > 0 then

			-- load mob
			local mob = Creature.getCreatures(target)

			-- when is valid.
			if table.count(mob) > 1 then

				-- load weapon id.
				local weapon = Self.Weapon()

				-- check for creature name
				if table.find(config.monsters, string.lower(mob.name)) then

					-- check for weapon
					if weapon.id ~= config.second then

						-- equip second weapon
						Self.EquipItem(SLOT_WEAPON, config.second, 1, 500)

					end	

				else	

					-- check for weapon (default first)
					if weapon.id ~= config.first then

						-- equip second weapon
						Self.EquipItem(SLOT_WEAPON, config.first, 1, 500)

					end	

				end	

			end	

		else	

			-- check for weapon (default first)
			if weapon.id ~= config.first then

				-- equip second weapon
				Self.EquipItem(SLOT_WEAPON, config.first, 1, 500)

			end	

		end	

	end	

end)
