--[[
    Script Name:        Auto Looting
    Description:        Sort loot between containers indexs.
    Author:             Ascer - example
]]

local LOOT = {

	{index = 0, items = {3031,3035}}, -- index of container to loot 0 = first open backpack, items = table with items id
	{index = 1, items = {3446}}
	-- add your next index here

}

local DELAY = {200, 500} -- delay between movements.


-- DONT'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       sortItems()
--> Description:    Stack items in containers. Will break after action.
--> Class:          None
--> Params:         None
-->                 
--> Return:         boolean true or false     
----------------------------------------------------------------------------------------------------------------------------------------------------------
function sortItems()

	-- load all containers items
	local contsItems = Container.getItems()

	-- in loop we check all containers items.
	for i, cont in ipairs(contsItems) do
		
		-- when table count is above 0
		if table.count(cont.items) > 0 then

			-- in loop for items in container.
			for j, item in ipairs(cont.items) do

				-- in loop for our loot table
				for k, lootCont in ipairs(LOOT) do

					-- check if table contains loot items and index is different.
					if table.find(lootCont.items, item.id) and (i-1) ~= lootCont.index then

						-- get empty slot in loot bp.
						local destCont = Container.getInfo(lootCont.index)
						local toSlot = 0

						-- when container is open
						if table.count(destCont) > 0 then

							-- calculate first empty slot.
							toSlot = destCont.size - (destCont.size - destCont.amount)

						end

						-- move item to destination container.
						return Container.MoveItemToContainer((i-1), (j-1), lootCont.index, (toSlot -1), item.id, item.count, math.random(DELAY[1], DELAY[2]))

					end
				
				end		

			end	

		end	

	end

end	


Module.New("Auto Looting", function (mod)
	
	-- call the function
	sortItems()

end)