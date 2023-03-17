--[[
    Script Name: 		Fishing
    Description: 		Go fishing :) personally love this.
    Author: 			Ascer - example
]]

local MAIN_DELAY = {1000, 1500}  				-- miliseconds use fishing rod time
local FISHING_ROD = 3483		 				-- fishing rod id
local WATER_TILES =  {617, 618, 619, 620, 621, 4597,4598,4599,4600, 4601, 4602, 4609}  -- ids of water fields
local MIN_CAP = -1								-- minimal capity to fishing.
local FISHING_WITH_USE_WATER = false			-- true/false - on some servers fishing is through usage of water. e.g. Souls of Elysium

-- DONT'T EDIT BELOW THIS LINE 

local selfloc, fishingPos = Self.Position(), {}

Module.New("Fishing", function (mod)
	if Self.isConnected() and Self.Capity() > MIN_CAP then
		local pos = Self.Position()
		local load = false
		
		-- check if position changed or fishingPos table is empty.
		if ((pos.x ~= selfloc.x) or (pos.y ~= selfloc.y) or (pos.z ~= selfloc.z)) or table.count(fishingPos) == 0  then 
			load = true
			selfloc = pos -- set last position
		end
		
		if load then -- load a new tiles
			fishingPos = {} -- reset fishing pos
			local osx, osy = 7, 5
			if FISHING_WITH_USE_WATER then
				osx = 1
				osy = 1
			end	
			for x = -osx, osx do
				for y = -osy, osy do
					local map = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)
					if table.find(WATER_TILES, map.id) then	
						table.insert(fishingPos, {x = pos.x + x, y = pos.y + y, z = pos.z, id = map.id})
					end		
				end
			end
		end

		-- set random tile to fish.
		if table.count(fishingPos) > 0 then
			local tile = fishingPos[math.random(1, table.count(fishingPos))] 
			if FISHING_WITH_USE_WATER then
				Map.UseItem(tile.x, tile.y, tile.z, tile.id, 0, 100)				-- use water tile.
			else	
				Self.UseItemWithGround(FISHING_ROD, tile.x, tile.y, tile.z, 100) 	-- use fishing rod.
			end	
		end	

	end	
	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)


