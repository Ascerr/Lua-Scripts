--[[
    Script Name:        Logout if item count
    Description:        Logout your character if item count is below x value.
    Author:             Ascer - example
]]

local ITEM = {id = 2853, count = 2}  -- item.id and item.count if below logout.

-- DON'T EDIT BELOW THIS LINE.

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getItemCount(itemid)
--> Description:    Read containers and equipment for count of items.
--> Class:          None
--> Params:         @itemid int which id we looking foor
--> Return:         int amount of items
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getItemCount(itemid)
    local count = Self.ItemCount(itemid)
    for i=0, 9 do
        local slot = selfGetEquipmentSlot(i)
        if slot.id == itemid then
            count = count + slot.count
        end    
    end
    return count 
end


-- Module to run functions in loop 200ms.
Module.New("Logout if item count", function ()
    if Self.isConnected() then
        if getItemCount(ITEM.id) < ITEM.count then
            Self.Logout()
        end
    end        
end)


