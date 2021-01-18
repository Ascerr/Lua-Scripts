--[[
    Script Name:        Drop Items
    Description:        Drop items under your character from any open container
    Author:             Ascer - example
]]

local ITEMS = {3031, 3492}			-- items to drop
local DROP_DELAY = {300, 1000} 		-- time between actions

-- DON'T EDIT BELOW THIS LINE

Module.New("Drop Items", function (mod)
	local item = Container.FindItem(ITEMS)
	if item ~= false then
		local pos = Self.Position()
		Container.MoveItemToGround(item.index, item.slot, pos.x, pos.y, pos.z, item.id, item.count) -- this function at least parameter set default delay for move items check for more detail in Rifbot Lib.lua
	end
	mod:Delay(DROP_DELAY[1], DROP_DELAY[2])	
end)
