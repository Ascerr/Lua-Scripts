--[[
    Script Name:        Destroy Furniture
    Description:        Search for ids of furniture around you (1 sqm) and use machete on it.
    Author:             Ascer - example
]]

local FURNITURE_IDS = {2982, 2472, 2524, 2319, 2358} -- list of items to destroy
local MACHETE_ID = 3308 -- id of weapon or machete to destroy.

-- DON'T EDIT BELOW

Module.New("Destroy Furniture", function (mod)

	if Self.isConnected() then
		local pos = Self.Position()
		for x = -1, 1 do
			for y = -1, 1 do
				local item = Map.GetTopMoveItem(pos.x+x, pos.y+y, pos.z)
				if table.find(FURNITURE_IDS, item.id) then
					-- destroy item
					Self.UseItemWithGround(MACHETE_ID, pos.x+x, pos.y+y, pos.z, math.random(1000, 1500))

					break
				end
			end	
		end
	end		
end) 
