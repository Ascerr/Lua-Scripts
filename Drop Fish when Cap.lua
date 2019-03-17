--[[
    Script Name:        Drop Fish when Cap
    Description:        Drop fish under your character when reach limit capity. 
    Author:             Ascer - example
]]

local FISH = 2667					-- items to drop
local CAPITY = 50					-- when below capity drop fish
local DROP_DELAY = {500, 1700} 		-- time between actions

-- DON'T EDIT BELOW THIS LINE

Module.New("Drop Fish when Cap", function()
	if Self.Capity() < CAPITY then
		local pos = Self.Position()
		Self.DropItem(pos.x, pos.y, pos.z, FISH, 100) -- we drop 100 this mean when will below this value drop full stack.
	end
	mod:Delay(DROP_DELAY[1], DROP_DELAY[2])	-- mod delay
end)