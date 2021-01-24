--[[
    Script Name:        Use Ground Around You
    Description:        Character will use map item around you 1sqm.
    Author:             Ascer - example
]]

local OPEN_DELAY = 200		-- use ground every 300 miliseconds (default)
local USE_STACK = 2			-- which stack we use. 0 - ground, 1 - sometimes ground or blood sometimes item, 2 - most of time dead body
local CROPSE_IDS = {3994, 5964}	-- enter here ids of dead monsters to open.


-- DONT'T EDIT BELOW THIS LINE

local lastPos = Self.Position()
local tablePos = {{-1, -1}, {-1, 0}, {-1, 1}, {1, -1}, {1, 0}, {1, 1}, {0, 1}, {0, -1}} 
local offset = 1

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMap(x, y, z)
--> Description: 	Read tile on x, y, z for table with items
--> Params:			
-->					@x coordinate in the map on the x-axis
-->					@y coordinate in the map on the y-axis
-->					@z coordinate in the map on the z-axis
--> Return: 		table = {{id=?, count=?}, {id2=?, count2=?}}	
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getTile(x, y, z)
	local map = Map.getArea(1)
	for i, square in pairs(map) do
		if square.x == x and square.y == y and square.z == z then 
			return square.items
		end	
	end
	return -1			
end	

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
	local map = getTile(pos.x + tablePos[offset][1], pos.y + tablePos[offset][2], pos.z)	

	-- set last pos
	lastPos = Self.Position()

	-- when map is different than -1
	if map ~= -1 then
		
		for i, item in pairs(map) do

			if table.find(CROPSE_IDS, item.id) then

				-- Use map.
				Map.UseItem(pos.x + tablePos[offset][1], pos.y + tablePos[offset][2], pos.z, item.id, i-1, 0)

				break

			end	
		
		end

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