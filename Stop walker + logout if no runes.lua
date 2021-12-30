--[[
    Script Name:        Stop Walker + Logout if No Runes
    Description:        Stop walker, but targeting is still ON to kill monsters and logout if no more runes.
    Authors:            Ascer, Markus Etschmayer
]]

local ITEM = {id = 3155, count = 20}  -- item.id and item.count if below logout.

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
Module.New("Stop Walker + Logout if No Runes", function ()
    if Self.isConnected() then
        if getItemCount(ITEM.id) < ITEM.count then
            if Walker.isEnabled() then Walker.Enabled(false) end
            Self.Logout()       
        end
    end        
end)