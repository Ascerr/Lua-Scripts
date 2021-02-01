--[[
    Script Name: 		Spear Pickup Medivia
    Description: 		Pickup spears if on Top or under dead body then shove.
    Required:			Rifbot 1.80+
 
    Author: 			Ascer - example
]]


local SPEAR_ID = 2389  	-- id of spear to pickup
local SPEED_TIME = 300	-- speed time do action in miliseconds

-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getSpearGround()
--> Description: 	Read ground 1sqm area around character for spears.
--> Params:			None
-->
--> Return: 		if true return table = {x, y, z} with spear map pos else return -1 if false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getSpearGround()

	-- load self pos.
	local pos = Self.Position()

	-- in loop read map for 1 range
	for x = -1, 1 do
		
		for y = -1, 1 do

			-- load map items.
			local map = Map.GetItems(pos.x + x, pos.y + y, pos.z)

			-- for items in loop
			for i,item in pairs(map) do
			 	
				-- when itemid is this same as spear.
				if item.id == SPEAR_ID then

					-- create return table.
					local tbl = {x = pos.x + x, y = pos.y + y, z = pos.z}

					-- return table.
					return tbl

				end	
			end 

		end

	end

	-- no item found return - 1
	return - 1

end	

-- Module to run function in loop.
Module.New("Spear Pickup Medivia", function()

	-- when connected.
	if Self.isConnected() then

		-- load ground spear pos.
		local spear = getSpearGround()

		-- when spear is diff than -1
		if spear ~= -1 then

			-- load top item on map.
			local top = Map.GetTopMoveItem(spear.x, spear.y, spear.z)

			-- when top is this same as spear.
			if top.id == SPEAR_ID then

				-- pick up
				Self.EquipItemFromGround(SLOT_WEAPON, spear.x, spear.y, spear.z, SPEAR_ID, top.count, SPEED_TIME)

			else

				-- load self pos.
				local pos = Self.Position()

				-- move item to you character pos.
				Map.MoveItem(spear.x, spear.y, spear.z, pos.x, pos.y, pos.z, top.id, top.count, SPEED_TIME)

			end	

		end	

	end	

end)