--[[
    Script Name:        Throw on ground all items except Gold
    Description:        Form opened containers throw on ground under your character all items but not gold.
    Required:           Rifbot version 2.27 or higher.
    Author:             Ascer - example
]]

local DONT_THROW_THIS_ITEMS = {3031, 3492}   -- list of items id to don't throw
local DELAY = {500, 800}                     -- random delay between actions       

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       LootSeller()
--> Description:    Read inside all opened containers for items and throw it execpt DONT_THROW_THIS_ITEMS list.
        
--> Return:         nil - nothing.   
----------------------------------------------------------------------------------------------------------------------------------------------------------
function throwItems()

    -- load all items.
    local items = Container.getItems()
    
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
            if not table.find(DONT_THROW_THIS_ITEMS, item.id) then
                
                -- load self pos.
                local pos = Self.Position()

                -- throw on ground.
                return Container.MoveItemToGround(cont.index, (j-1), pos.x, pos.y, pos.z, item.id, item.count, 0)

            end 

        end

    end    

end 

Module.New("Throw on ground all items except Gold", function (mod)

    -- when connected
    if Self.isConnected() then

        throwItems()

    end    

    -- mod delay
    mod:Delay(DELAY[1], DELAY[2])

end)