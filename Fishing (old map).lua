--[[
    Script Name: 		Fishing
    Description: 		Go fishing :) personally love this.
    Author: 			Ascer - example
]]

local MAIN_DELAY = {1500, 2900}  -- miliseconds use fishing rod time
local FISHING_ROD = 3483		 -- fishing rod id
local WATER_TILES = {4597,4598,4599,4600, 4601, 4602, 4609} --{4597, 4598, 4599, 4600, 4601, 4602}  -- {617, 618, 619, 620, 621}   {4597,4598,4599,4600, 4601, 4602, 4609}  -- ids of water fields

-- DONT'T EDIT BELOW THIS LINE 

local selfloc, fishingPos = Self.Position(), {}

Module.New("fishing", function (mod)
	if Self.isConnected() then
		local pos = Self.Position()
		local load = false
		
		-- check if postion changed or fishingPos table is empty.
		if ((pos.x ~= selfloc.x) or (pos.y ~= selfloc.y) or (pos.z ~= selfloc.z)) or table.count(fishingPos) == 0  then 
			load = true
			selfloc = Self.Position() -- set last position
		end
		
		if load then -- load a new tiles
			fishingPos = {} -- reset fishing pos
			local map = Map.getArea(7) -- load map is CPU eatable function be careful with using it.	
			for i, square in pairs(map) do
				if square.amount == 1  then -- check only for tile contains 1 item
					local items = square.items
					for j, item in pairs(items) do
						print(item.id)
						if table.find(WATER_TILES, item.id) then
							table.insert(fishingPos, {x = square.x, y = square.y, z = square.z})
						end
					end
				end
			end
		end

		-- set random tile to fish.
		if table.count(fishingPos) > 0 then
			local tile = fishingPos[math.random(1, table.count(fishingPos))] 
			Self.UseItemWithGround(FISHING_ROD, tile.x, tile.y, tile.z, 100) -- use fishing rod.
		end	

	end	
	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)


