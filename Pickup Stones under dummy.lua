--[[
    Script Name: 		Pickup Stones under dummy
    Description: 		Pickup stones under training dummy to weapon slot.    					
    Author: 			Ascer - example 
]]


local STONE = 1781				-- stones id
local DELAY = {2000, 3000}		-- delay between pickup

-- DONT EDIT BELOW THIS LINE

Module.New("Pickup Stones under dummy", function(mod)
	
	-- load target id.
	local target = Self.TargetID()

	-- load creature based on target
	local t = Creature.getCreatures(target)

	-- when creature is valid.
	if table.count(t) > 2 then

		-- load position under target
		local map = Map.GetItems(t.x, t.y, t.z)

		-- inside loop check for items.
		for i, sqm in ipairs(map) do

			-- when item is stone
			if sqm.id == STONE then

				-- wear stone from ground
				Self.EquipItemFromGround(SLOT_WEAPON, t.x, t.y, t.z, sqm.id, sqm.count, 0)

				-- destroy loop
				break

			end	

		end	

	end	

	-- set mod delay
	mod:Delay(DELAY[1], DELAY[2])

end)

