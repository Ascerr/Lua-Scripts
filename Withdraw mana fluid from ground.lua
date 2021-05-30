--[[
    Script Name:        Withdraw mana fluid from ground
    Description:        Will withdraw mana fluids up to capity from bag container on ground.
    Required:			I cavebot do like this: 
    						stand 33423, 32423, 7
    						manas
    						wait: 200
    						lua: if Rifbot.ScriptIsRunning("Withdraw mana fluid from ground") then Walker.Goto("manas") else Rifbot.ExecuteScript("Withdraw mana fluid from ground", true) end
    						node: 33425, 32427, 7
    						..
    Author:             Ascer - example
]]


local BAG_ID = 2853			-- id of bag lay on ground (bag->bag->..)
local AMOUNT = 5			-- withdraw up to this amount (counting only manas from backpack)
local WITHDRAW_POS = {x = 32341, y = 32221, z = 8} -- ground position where lay bag
local WITHDRAW_CONT = 0		-- index container where we withdraw (default 0 first backpack, max withdraw amount is size of backpack)
local LABEL = "manas"		-- name of label before we execute lua


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

-- load amount of manas
local manas = Self.ItemCount(MANA_FLUID.id, WITHDRAW_CONT)

-- when amount in first container will below our withdraw amount.
if manas < AMOUNT then

	-- load bag container
	local index, bag = getCont(BAG_ID)

	-- when not open
	if bag == -1 then

		-- use map position. every 1s
		Map.UseItem(WITHDRAW_POS.x, WITHDRAW_POS.y, WITHDRAW_POS.z, BAG_ID, 1, 1000)


	else

		--> throw out empty vials.

		-- load items withdraw to cont
		local items = Container.getItems(WITHDRAW_CONT)

		-- for items
		for i, item in ipairs(items) do

			-- when we found fluids.
			if item.id == MANA_FLUID.id then

				-- when we found vials.
				if item.count ~= MANA_FLUID.count then

					-- load my position
					local myPos = Self.Position()

					-- drop it under your character.
					Container.MoveItemToGround(WITHDRAW_CONT, (i - 1), myPos.x, myPos.y, myPos.z, MANA_FLUID.id, 1, 500)

					-- add offset we moving item
					offset = offset + 1

					-- destroy loop
					break

				end
			
			end		

		end		

		--> pickup mana fluids

		-- load items from bag
		local items = Container.getItems(index)

		-- for items
		for i, item in ipairs(items) do

			-- when we found fluids.
			if item.id == MANA_FLUID.id then

				-- when we found vials.
				if item.count ~= MANA_FLUID.count then

					-- load my position
					local myPos = Self.Position()

					-- drop it under your character.
					Container.MoveItemToGround(index, i - 1, myPos.x, myPos.y, myPos.z, MANA_FLUID.id, 1, 500)

				else	

					-- calculate amount to pickup.
					local toPickup = AMOUNT - manas

					-- when amount to pickup is above slot.count set max.
					if toPickup > item.count then
						toPickup = item.count
					end	

					-- move manas to our cont.
					Container.MoveItemToContainer(index, i - 1, WITHDRAW_CONT, 0, item.id, toPickup, 500)

				end	

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

				-- when we found manas.
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

				-- set offset -1 we and with no manas 
				offset = -1

				-- show msg.
				print("No more mana fluids to pickup")

			end		

		end	

	end	

	-- go to label
	if offset >= 0 then

		Walker.Goto(LABEL)

	end

else		

	-- show valid.
	print("We have " .. AMOUNT .. " manas.")

end	
