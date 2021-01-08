--[[
    Script Name: 		Anti Push if Player
    Description: 		Drop shit under yourself if player detected.
    Author: 			Ascer - example
]]


local DROP_DELAY = {200, 400}			 -- loop reading module
local TRASH = {3031, 3147, 3507, 3447}	 -- trash items, gold, blank rune, label
local RANDOM_ITEM = true					-- drop random item from trash

-- DONT'T EDIT BELOW THIS LINE

local dropTime, dropDelay, friends = 0, 0, Rifbot.FriendsList(true)


function getPlayer()
	for i, c in pairs(Creature.iPlayers(7)) do
		if Creature.isOnScreen(c) then
			return true
		end	
	end
	return false	
end	

Module.New("Anti Push if Player", function ()
	if os.clock() - dropTime > dropDelay then -- check for delay
		local chooseItem = TRASH
		if RANDOM_ITEM then
			chooseItem = TRASH[math.random(#TRASH)] 
		end	
		local item = Container.FindItem(chooseItem) -- search item in container
		if item ~= false and getPlayer() then
			local pos = Self.Position()
			Container.MoveItemToGround(item.index, item.slot, pos.x, pos.y, pos.z, item.id, 1) -- move first found item from TRASH list with quantity 1
			dropTime = os.clock()
			dropDelay = math.random(DROP_DELAY[1], DROP_DELAY[2])/1000 -- set new delay 
		end
	end		
end)	