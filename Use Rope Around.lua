--[[
    Script Name:        Use Rope Around
    Description:        Character will use rope item around you 1sqm.
    Author:             Ascer - example
]]

local USE_DELAY = 1000		-- use every 1000 miliseconds (default)
local ROPE_ID = 3003		-- id of rope.


-- DONT'T EDIT BELOW THIS LINE

local lastPos = Self.Position()
local tablePos = {{-1, -1}, {-1, 0}, {-1, 1}, {1, -1}, {1, 0}, {1, 1}, {0, 1}, {0, -1}} 
local offset = 1


-- run function in loop here
Module.New("Use Rope Around", function (mod)
	
	-- load pos
	local pos = Self.Position()

	-- when current pos is diff than last pos reset offset
	if pos.x ~= lastPos.x or pos.y ~= lastPos.y or pos.z ~= lastPos.z then

		-- rest offset
		offset = 1

	end	

	-- set last pos
	lastPos = Self.Position()

	-- Use map.
	Self.UseItemWithGround(ROPE_ID, pos.x + tablePos[offset][1], pos.y + tablePos[offset][2], pos.z, 0)

	-- add offset
	offset = offset + 1

	-- when offset is equal or higher than 9 reset
	if offset >= 9 then 

		offset = 1

	end	

	-- set module delay.
	mod:Delay(USE_DELAY)

end)