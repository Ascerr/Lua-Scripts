--[[
    Script Name:        Drop Vials
    Description:        Drop empty vials under your character or near around.
    Author:             Ascer - example
]]

local VIAL = {id = 2874, count = 0}			-- vial id and count of vial slot. (DON'T CHANGE COUNT)
local DROP_DELAY = {300, 1000} 				-- time between actions
local RANDOMIZE_DROP_POS = false			-- drop vial to random pos true/false 

-- DON'T EDIT BELOW THIS LINE

Module.New("Drop Vials", function ()
	local items = Container.getItems()
	for i = 1, #items do
		local cont = items[i]
		local contItems = cont.items
		for j = 1, #contItems do
			local item = contItems[j]
			if item.id == VIAL.id then
				if item.count == VIAL.count then
					local pos = Self.Position()
					local osx, osy = 0, 0
					if RANDOMIZE_DROP_POS then
						osx = math.random(-1, 1)
						osy = math.random(-1, 1)
					end	
					Container.MoveItemToGround(cont.index, (j - 1), pos.x + osx, pos.y + osy, pos.z, item.id, item.count) -- this function at least parameter set default delay for move items check for more detail in Rifbot Lib.lua
					break
				end	
			end
		end	
	end
	mod:Delay(DROP_DELAY[1], DROP_DELAY[2])	
end)
