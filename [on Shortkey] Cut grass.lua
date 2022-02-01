--[[
    Script Name:        [on Shortkey] Cut grass
    Description:        Cut grass near you, its shortkey usage script type: EXECUTE name
    Author:             Ascer - example
]]


local config = {
   machete = 3308,			-- id of item to cut
   grass = {3243, 2344}		-- possible grass id
}

-- load self position
local pos = Self.Position()

-- load map around our character and use machete if grass found.
for x = -1, 1 do
	for y = -1, 1 do
		if table.find(config.grass, Map.GetTopMoveItem(pos.x+x, pos.y+y, pos.z).id) then
			Self.UseItemWithGround(config.machete, pos.x+x, pos.y+y, pos.z, 0)
			break
		end	
	end
end		
