--[[
    Script Name: 		Restore weapon after creating rune
    Description: 		When you create rune on server where putting blank to hand is required, after creating rune script will restore weapon. 
    Required: 			Must be hand most left
    Author: 			Ascer
]]

local CREATED_RUNE_ID = 2311			-- ID of rune you creating (default: 2311 hmm)
local WEAPON_ID = 2423					-- weapon ID to restore.

-- DON'T EDIT BELOW THIS LINE
Module.New("Restore weapon after creating rune", function(mod)

	-- when connected.
	if Self.isConnected() then

		-- load slot.
		local slot = Self.Weapon()
 		local found = false

		-- when hand has rune id.
		if slot.id == CREATED_RUNE_ID then

			-- load containers items
			local conts = Container.getItems()

			-- inside loop manage items
			for j = 1, table.count(conts) do

				-- set cont and items
				local cont = conts[j]
        		local items = cont.items

        		-- inside loop for cont items
        		for i = 1, table.count(items) do

        			-- load single item
        			local item = items[i]

        			-- when item id is this same as rune
        			if item.id == CREATED_RUNE_ID then

        				-- load cont info
        				local dest = Container.getInfo(cont.index)

        				-- when amount of items in table is good.
        				if table.count(dest) > 0 then

        					-- when cont is not full
        					if dest.amount < dest.size then

        						-- dequip rune
        						Self.DequipItem(SLOT_WEAPON, cont.index, (i - 1))

        						-- set found 
        						found = true

        					end

        				end	

        			end	

        		end	

			end

			-- when we not found any cont just dequip anywhere
			Self.DequipItem(SLOT_WEAPON)

		-- when nothing inside slot
		elseif slot.id == 0 then
			
			-- equip weapon
			Self.EquipItem(SLOT_WEAPON, WEAPON_ID, 1)

		end	

	end	

	mod:Delay(1000)

end)