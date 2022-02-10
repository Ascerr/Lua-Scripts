--[[
    Script Name:        Destroy Furniture
    Description:        Search for ids of furniture around you and use machete on it.
    Author:             Ascer - example
]]

local FURNITURE_IDS = {2982, 2472, 2524, 2319, 2358, 3504} -- list of items to destroy
local MACHETE_ID = 3308 	-- id of weapon or machete to destroy.
local RANGE = 1				-- distance between you and furniture	

-- DON'T EDIT BELOW

Module.New("Destroy Furniture", function (mod)

	if Self.isConnected() then
		
		local furnitures = {}
		local pos = Self.Position()
		
		-- get all possible furnitures in range.
		for x = -RANGE, RANGE do
			for y = -RANGE, RANGE do
				local item = Map.GetTopMoveItem(pos.x+x, pos.y+y, pos.z)
				if table.find(FURNITURE_IDS, item.id) then
					table.insert(furnitures, {x = pos.x+x, y = pos.y+y, z = pos.z, id = item.id})
				end
			end	
		end

		local object, lastDist = -1, 10

		-- get the closetst furniture
		for i, furniture in ipairs(furnitures) do
			local dist = Self.DistanceFromPosition(furniture.x, furniture.y, furniture.z)
			if dist < lastDist then
				object = furniture
				lastDist = dist
			end	 
		end	

		-- destroy item
		if object ~= -1 then
			Self.UseItemWithGround(MACHETE_ID, object.x, object.y, object.z, math.random(1000, 1500))
		end	

	end		
end) 
