--[[
    Script Name:        Withdraw bolts from ground bag
    Description:        Will withdraw bolts up to capity from bag container on ground.
    Required:			In cavebot do like this: 
    						stand 33423, 32423, 7
    						bolts
    						lua: if Rifbot.ScriptIsRunning("Withdraw bolts from ground bag") then Walker.Goto("bolts") else Rifbot.ExecuteScript("Withdraw bolts from ground bag", true) end
    						node: 33425, 32427, 7
    						..
    Author:             Ascer - example
]]


local BOLTS_ID = 3446		-- id of bolts to withdraw.
local BAG_ID = 2853			-- id of bag
local AMOUNT = 400			-- withdraw up to this amount (counting only bolts from backpack)
local WITHDRAW_POS = {x = 32359, y = 32221, z = 8} -- ground position where lay bag
local WITHDRAW_CONT = 0		-- index container where we withdraw (default 0 first backpack)
local LABEL = "bolts"		-- name of label before we execute lua


-- DONT EDIT BELOW THIS LINE

local offset = 0

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getCont(id)
--> Description: 	Read for container id
--> Class: 			none	
--> Params:			
-->					@id number 0-15
-->	
--> Return: 		on fail return -1, -1,  else return index, container table = {id = ?, name = ?, size = ?, amount = ?}	
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCont(id)
	for i = 0, 15 do
		local cont = Container.getInfo(i)
		if table.count(cont) > 1 then
			if cont.id == id then
				return i, cont
			end	
		end	
	end
	return -1, -1	
end	


-- load amount of bolts
local bolts = Self.ItemCount(BOLTS_ID, WITHDRAW_CONT)

-- when amount in first container will below our withdraw amount.
if bolts < AMOUNT then
	
	-- load bag container
	local index, bag = getCont(BAG_ID)

	-- when not open
	if bag == -1 then

		-- use map position. every 1s
		Map.UseItem(WITHDRAW_POS.x, WITHDRAW_POS.y, WITHDRAW_POS.z, BAG_ID, 1, 1000)

	else
		
		-- load items from bag
		local items = Container.getItems(index)

		-- for items
		for i, item in ipairs(items) do

			-- when we found bolt.
			if item.id == BOLTS_ID then

				-- calculate amount to pickup.
				local toPickup = AMOUNT - bolts

				-- when amount to pickup is above slot.count set max.
				if toPickup > item.count then
					toPickup = item.count
				end	

				-- move bolts to our cont.
				Container.MoveItemToContainer(index, i - 1, WITHDRAW_CONT, 0, item.id, toPickup, 500)

				-- add offset we moving item
				offset = offset + 1

				-- destroy loop
				break

			end	

		end	

		-- when offset is 0
		if offset == 0 then

			-- search items from next back to open.
			for i, item in ipairs(items) do

				-- when we found bolt.
				if item.id == BAG_ID then

					-- open next bp
					Container.UseItem(index, i - 1, item.id, false, 1000)

					-- add offset
					offset = offset + 1

					-- end loop
					break

				end	

			end

			-- when offset 0
			if offset == 0 then

				-- set offset -1 we and with no bolts 
				offset = -1

				-- show msg.
				print("No more bolts to withdraw")

			end		

		end	

	end	

	-- go to label
	if offset >= 0 then

		Walker.Goto(LABEL)

	end	

end	
