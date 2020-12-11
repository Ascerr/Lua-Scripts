--[[
    Script Name:        Equip ring if attack monster
    Description:       	When you attacking specific monsters equip ring else dequip.
    Author:             Ascer - example
]]

local RING_ID = {on = 2205, off = 2168} 		-- ring id: on -> id when you wear ring, off -> id in backpack.
local MONSTERS = {"Dragon", "Dragon Lord"} 		-- eneter here monsters name.


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getAttackedMonster()
--> Description: 	Return table with monster you attacking or nil if not attacking. 
--> Params:			
--> Return: 		table = {id = ?, name = ?, x = ?, y = ?, z = ?, hpperc = ?, alive = ?, direction = ?, addr = ?, attack = ?, party = ?}
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getAttackedMonster()
	local target = Self.TargetID()
	if target <= 0 then return end
	target = Creature.getCreatures(target)
	if table.count(target) < 2 then return end
	return target 
end


--  DON'T EDIT BELOW THIS LINE

-- change monsters table to lower case.
MONSTERS = table.lower(MONSTERS)

Module.New("Equip ring if attack monster", function ()
	
	-- set param for calculation.
	local can = false

	-- when connected 
	if Self.isConnected() then

		-- load attacked creature.
		local attack = getAttackedMonster()

		-- when is target
		if attack ~= nil then

			-- check if creature has valid name.
			if table.find(MONSTERS, string.lower(attack.name)) then

				-- set can true.
				can = true	

			end		

		end

		-- load self.ring
		local ring = Self.Ring()

		-- when can wear ring.
		if can then

			-- if we dont have ring in eq wear.
			if ring.id ~= RING_ID.on then

				-- wear ring.
				Self.EquipItem(SLOT_RING, RING_ID.off, 1)

			end

		-- we dequip ring.
		else

			-- when we have ring in eq.
			if ring.id == RING_ID.on then

				-- dequip ring.
				Self.DequipItem(SLOT_RING)

			end	

		end	

	end			
	
end)
