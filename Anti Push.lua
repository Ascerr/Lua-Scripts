--[[
    Script Name: 		Anti Push
    Description: 		Drop shit under yourself. Required Rifbot v1.31
    Author: 			Ascer - example
]]

local DROP_DELAY = {1000, 2000}			 -- loop reading module
local TRASH = {3031, 3147, 3507}	 -- trash items, gold, blank rune, label

-- DONT'T EDIT BELOW THIS LINE

local dropTime, dropDelay = 0, 0

Module.New("Anti Push", function ()
	if os.clock() - dropTime > dropDelay then -- check for delay
		local item = Container.FindItem(TRASH) -- search item in container
		if item ~= false then
			local pos = Self.Position()
			Container.MoveItemToGround(item.index, item.slot, pos.x, pos.y, pos.z, item.id, 1) -- move first found item from TRASH list with quantity 1
			dropTime = os.clock()
			dropDelay = math.random(DROP_DELAY[1], DROP_DELAY[2])/1000 -- set new delay 
		end
	end		
end)	