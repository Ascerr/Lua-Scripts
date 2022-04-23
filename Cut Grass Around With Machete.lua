--[[
    Script Name:        Cut Grass Around With Machete
    Description:        Cut grass near you.
    Author:             Ascer - example
]]


local config = {
   machete = 3308,			-- id of item to cut
   grass = {3243, 2344}		-- possible grass id
}


-- DON'T EDIT BELOW THIS LINE

-- module 200ms or faster if teleported enabled
Module.New("Cut Grass Around With Machete", function (mod)

	-- load self position
	local pos = Self.Position()

	-- load map around our character and use machete if grass found.
	for x = -1, 1 do
		for y = -1, 1 do
			if table.find(config.grass, Map.GetTopMoveItem(pos.x+x, pos.y+y, pos.z).id) then
				Self.UseItemWithGround(config.machete, pos.x+x, pos.y+y, pos.z, 1000)
				break -- destroy loop
			end	
		end
	end

	-- module delay
	mod:Delay(400, 900)

end)			
