--[[
    Script Name:        Drop Runes Bp's to House
    Description:        Drop Whole Backpack with done runes to specific location e.g. your house.
    Required:			[IMPORTANT] You have to all bps with runes inside your main backpack and all need to be open as first, second, ..
    					To open backpacks after relogin you can use Reconnect Backpacks.lua 
    Author:             Ascer - example
]]

------------------------------------------
-- CONFIG SECTION
------------------------------------------
local possibleBackpackIDs = {2854, 2867, 2866, 2869}  -- it's list of backpacks we looking for, add yours

local creatingRuneID = 3160 -- id of rune you create now, (default UH's)

local groundDropPosition = {x = 32356, y = 32214, z = 7} -- position x, y, z where you want to drop your backpack full or runes

------------------------------------------
-- MODULE SECTION / DON'T EDIT BELOW
------------------------------------------

local offset = 0

Module.New("Drop Runes Bp's to House", function (mod)

	-- load containers items for later reading info.
	local items = Container.getItems()

	-- inside loop check for any full bp already created runes.
    for i = 1, #items do
        
    	-- load single table with container
        local container = items[i]

        -- load items of container
        local contItems = container.items
        
        -- inside loop check each item in container
        for slot = 1, #contItems do

        	-- load item
            local item = contItems[slot]
            
            -- check for valid id inside cont slot
            if item.id == creatingRuneID then
            	
            	-- increase offset by 1 to calculate amount of already done runes
            	offset = offset + 1

            end	

        end

        -- when offset reach 20 (it's limit of runes for drop backpack) then
        if offset >= 20 then

        	-- find first backpack to drop. (we searching all bps for full backpack with runes to drop) // when failed use just first index Container.FindItem(possibleBackpackIDs, 0)
        	local backpack = Container.FindItem(possibleBackpackIDs)

        	-- check if backpack was found.
        	if backpack then 

        		-- drop backpack with runes to specific location.
        		Container.MoveItemToGround(backpack.index, backpack.slot, groundDropPosition.x, groundDropPosition.y, groundDropPosition.z, backpack.id, 1)

        	end

        	-- reset offset.
        	offset = 0

        	-- break loop we just finish.
        	break

        end	

        -- reset offset.
        offset = 0

    end

    -- mod delay
    mod:Delay(700, 1200)

end)