--[[
    Script Name:        [on label] Pickup Loot From Ground 
    Description:        When character in walker reach label "pickup" then it will collect loot to backpack.
    Author:             Ascer - example
]]

local config = {
    label_name = "pickup",                  -- do this action on this current label in walker.
    pos = {x = 32349, y = 32231, z = 6},    -- position where lay loot on ground.
    container_index = 0,                    -- pickup to container index (default = 0 first opened backpack)
    items = {3031, 3507},                   -- items to pickup.
    min_cap = 50                            -- minimal capity to stop pickup.     
}

-- DON'T EDIT BELOW

function signal(label)
    
    if label == config.label_name then
        
        while true do
            
            -- wait to prevent program hangs.
            wait()

            -- when reached min capity return.
            if Self.Capity() <= 50 then return end
            
            -- load current map id.
            local map = Map.GetTopMoveItem(config.pos.x, config.pos.y, config.pos.z)

            -- when map.id is different than items we pickup return
            if not table.find(config.items, map.id) then return end

            -- load deposit container.
            local cont = Container.getInfo(config.container_index)

            -- when backpack is not opened return.
            if table.count(cont) < 2 then 

                --- show error
                print("Pickup Items: container index " .. config.container_index .. " is closed.")

                -- return
                return

            end    

            -- check if cont is full
            if cont.size == cont.amount then

                -- check for possible container to open.
                local contItems = Container.getItems(config.container_index)

                -- set param for opening new cont
                local isNewCont = false

                -- in loop check items.
                for i, item in ipairs(contItems) do

                    -- when is container attr
                    if Item.hasAttribute(item.id, ITEM_FLAG_CONTAINER) then

                        -- open container in this same index with delay 1000.
                        Container.UseItem(config.container_index, (i - 1), item.id, false, 1000)

                        -- set param true is new cont to open.
                        isNewCont = true

                        -- break loop
                        break

                    end

                end    

                -- when param is false
                if not isNewCont then

                    -- show error
                    print("Pickup Items: Failed to find next container to deposit loot.")

                    -- return
                    return

                end

            -- container have free slots to put items.
            else    

                -- set slot where we put item from ground.
                local toSlot = cont.amount

                -- put items with random delay 500-700 ms
                Self.PickupItem(config.pos.x, config.pos.y, config.pos.z, map.id, map.count, config.container_index, toSlot, math.random(500, 700))

            end    

        end

    end

end

-- call function
Walker.onLabel("signal")