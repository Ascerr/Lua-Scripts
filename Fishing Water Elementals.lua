--[[
    Script Name: 		Fishing Water Elementals
    Description: 		Using rod on water elementals for new map struct.
    Author: 			Ascer - example
]]

local MAIN_DELAY = {3000, 3500}  	-- miliseconds use fishing rod time
local FISHING_ROD = 3483		 	-- fishing rod id
local WATER_TILES = {5522}  		--ids of water fields

-- DONT'T EDIT BELOW THIS LINE 

Module.New("Fishing Water Elementals", function (mod)
	if Self.isConnected() then
		local fishingPos = {}
		local pos = Self.Position()
		for x = -7, 7 do
			for y = -5, 5 do
				local map = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)
				if table.find(WATER_TILES, map.id) then	
					table.insert(fishingPos, {x = pos.x + x, y = pos.y + y, z = pos.z})
				end		
			end
		end
		if table.count(fishingPos) > 0 then
			local tile = fishingPos[math.random(1, table.count(fishingPos))] 

			Self.UseItemWithGround(FISHING_ROD, tile.x, tile.y, tile.z, 100) -- use fishing rod.
		end	
	end	
	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)


