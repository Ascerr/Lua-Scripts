--[[
    Script Name:        Use Ground Around You
    Description:        Character will use map item around you 1sqm.
    Author:             Ascer - example
]]

local OPEN_DELAY = 200		-- use ground every 200 miliseconds (default)
local CROPSE_IDS = {3994, 5964, 4173}	-- enter here ids of dead monsters to open.


-- DONT'T EDIT BELOW THIS LINE

local lastPos = Self.Position()
local tablePos = {{-1, -1}, {-1, 0}, {-1, 1}, {1, -1}, {1, 0}, {1, 1}, {0, 1}, {0, -1}} 
local offset = 1


-- run function in loop here
Module.New("Use Ground Around You", function (mod)
	
	-- load pos
	local pos = Self.Position()

	-- when current pos is diff than last pos reset offset
	if pos.x ~= lastPos.x or pos.y ~= lastPos.y or pos.z ~= lastPos.z then

		-- rest offset
		offset = 1

	end	

	-- load map
	local map = Map.GetTopMoveItem(pos.x + tablePos[offset][1], pos.y + tablePos[offset][2], pos.z)

	-- set last pos
	lastPos = Self.Position()

	if table.find(CROPSE_IDS, map.id) then

		-- Use map.
		Map.UseItem(pos.x + tablePos[offset][1], pos.y + tablePos[offset][2], pos.z, map.id, 1, 0)

	end	


	-- add offset
	offset = offset + 1

	-- when offset is equal or higher than 9 reset
	if offset >= 9 then 

		offset = 1

	end	

	-- set module delay.
	mod:Delay(OPEN_DELAY)

end)
