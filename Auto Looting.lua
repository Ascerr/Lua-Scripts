--[[
    Script Name:        Auto Looting
    Description:        Sort loot between containers indexs.
    Author:             Ascer - example
]]

local LOOT = {

	{index = 0, items = {3031, 3492, 7138,  3577}}, -- index of container to loot 0 = first open backpack, items = table with items id
	--{index = 0, items = {3031, 2853, "*"}}				-- here is example how to pickup all items "*" from container CROPSE missing only this ids listed: Character will pickup all items without gold and bag.
	-- add your next index here

}

local DELAY = {200, 500} -- delay between movements.
local CROPSE = {"The", "Demonic", "Dead", "Slain", "Dissolved", "Remains", "Elemental", "Split"} -- names of dead cropses, add your if list no contains enough, top pickup from bag add it to list: "Bag"
local OPEN_NEXT_CONT_IF_FULL = true	-- when container you pickup loot is full open next as this same index.

-- DONT'T EDIT BELOW THIS LINE

function getCropse(name)
    for _, element in ipairs(table.lower(CROPSE)) do
        if string.lower(name):find(element) then
            return true
        end
    end
    return false
end --> check if cropse name match to CROPSE table.

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
					if (table.find(lootCont.items, item.id) or table.find(lootCont.items, "*")) and (cont.index) ~= lootCont.index then

						-- set default allow pickup on true
						local allow = true

						-- when we picking all items
						if table.find(lootCont.items, "*")  then

							-- when loot contains items to from table then don't pickup it
							if table.find(lootCont.items, item.id) then

								-- set pickup to false
								allow = false

							end	

							-- load info about container.
        					local contInfo = Container.getInfo(cont.index)

       						-- check for container name if contains dead cropse words.
        					if not getCropse(contInfo.name) then

        						-- allow pickup
        						allow = false

        					end	

        				end		

        				-- when allow pickup
        				if allow then

							-- get empty slot in loot bp.
							local destCont = Container.getInfo(lootCont.index)
							local toSlot = 0

							-- when container is open
							if table.count(destCont) > 0 then

								-- check if cont is full
					            if destCont.size == destCont.amount then

					                -- check for possible container to open.
					                local contItems = Container.getItems(lootCont.index)

					                -- set param for opening new cont
					                local isNewCont = false

					                -- in loop check items.
					                for m, it in ipairs(contItems) do

					                    -- when is container attr
					                    if Item.hasAttribute(it.id, ITEM_FLAG_CONTAINER) then

					                        -- open container in this same index with delay 1000.
					                        return Container.UseItem(lootCont.index, (m - 1), it.id, false, 1000)

					                    end

					                end

					            end

								-- calculate first empty slot.
								toSlot = destCont.size

							end

							-- move item to destination container.
							return Container.MoveItemToContainer(cont.index, (j-1), lootCont.index, (toSlot -1), item.id, item.count, 0)

						end	

					end
				
				end		

			end	

		end	

	end

end	


Module.New("Auto Looting", function (mod)
	
	-- call the function
	sortItems()

	-- mod delay
	mod:Delay(DELAY[1], DELAY[2])

end)
