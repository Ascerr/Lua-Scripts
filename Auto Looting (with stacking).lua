--[[
    Script Name:        Auto Looting
    Description:        Sort loot between containers indexs.
    Author:             Ascer - example
]]

local LOOT = {

	{index = 0, items = {3031, 3492, 7138,  3577, 2148}}, -- index of container to loot 0 = first open backpack, items = table with items id
	{index = 1, items = {3446}}
	-- add your next index here

}

local DELAY = {300, 500} -- delay between movements.


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
					if table.find(lootCont.items, item.id) and (cont.index) ~= lootCont.index then

						-- when item is stackable
						if Item.hasAttribute(item.id, ITEM_FLAG_STACKABLE) then

							-- in loop for table with items
							for h, stackConts in ipairs(contsItems) do

								-- when index will this same as loot to cont
								if stackConts.index == lootCont.index then

									-- --> [Auto item stacket] for loop to all items
									for p, stackItem in ipairs(stackConts.items) do

										-- when id will this same and count will below 100
										if stackItem.id == item.id and stackItem.count < 100 then

											-- stack items
											return Container.MoveItemToContainer(cont.index, (j-1), lootCont.index, (p-1), item.id, item.count, math.random(DELAY[1], DELAY[2]))
		
										end

									end

								end					

							end

						end

						-- get empty slot in loot bp.
						local destCont = Container.getInfo(lootCont.index)
						local toSlot = 0

						-- when container is open
						if table.count(destCont) > 0 then

							-- calculate first empty slot.
							toSlot = destCont.size - (destCont.size - destCont.amount)

						end

						-- move item to destination container.
						return Container.MoveItemToContainer(cont.index, (j-1), lootCont.index, (toSlot -1), item.id, item.count, math.random(DELAY[1], DELAY[2]))

					end
				
				end		

			end	

		end	

	end

end	


Module.New("Auto Looting", function ()
	
	-- call the function
	sortItems()

end)