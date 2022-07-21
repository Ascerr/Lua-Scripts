--[[
    Script Name:        Use LootSeller Item
    Description:        Use loot seller item on list of items available in all opened containers.
    Required:           Rifbot version 2.27 or higher.
    Author:             Ascer - example
]]

local ITEM_SELLER = 23722         -- id of loot seller
local LOOT = {3376, 3274, 3374}   -- possible list of item to use with.       

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       LootSeller()
--> Description:    Read inside all opened containers for loot to sell and then use loot seller item on it.
        
--> Return:         nil - nothing.   
----------------------------------------------------------------------------------------------------------------------------------------------------------
function LootSeller()

    -- load all items.
    local items = Container.getItems(special)
    
    -- for all items
    for i = 1, #items do
        
        -- load container and their items
        local cont = items[i]
        local contItems = cont.items
        
        -- for items inside single container
        for j = 1, #contItems do
        
            -- load single item
            local item = contItems[j]

            -- when we found loot to sell
            if table.find(LOOT, item.id) then
                
                -- find loot seller item
                local seller = Container.FindItem(ITEM_SELLER)
                
                -- when item found
                if table.count(seller) > 2 then
                    
                    -- use item with loot
                    return Container.UseItemWithContainer(seller.index, seller.slot, seller.id, cont.index, (j - 1), item.id, 0)

                else 

                    -- show error item not found
                    print("LootSeller item not found inside opened containers.")

                end

            end 

        end

    end    

end 

Module.New("Use LootSeller Item", function (mod)

    -- when connected
    if Self.isConnected() then

        LootSeller()

    end    

    -- mod delay
    mod:Delay(500, 1000)

end)