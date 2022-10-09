--[[
    Script Name:        [on label] Drop loot to ground
    Description:        When character in walker reach label "drop" then it will drop item from specific backpack to ground.
    Author:             Ascer - example
]]

local config = {
    label_name = "drop",                    -- do this action on this current label in walker.
    pos = {x = 32033, y = 32237, z = 8},    -- position where lay loot on ground.
    container_index = 0,                    -- pickup to container index (default = 0 first opened backpack)
    items = {3031, 2920},                   -- items to pickup.
    open_next_bp = true                     -- true/false open nexe bp when no more items found to drop in current   
}

-- DON'T EDIT BELOW

function signal(label)
    
    if label == config.label_name then
        
        while true do
            
            -- wait to prevent program hangs.
            wait()

            -- load deposit container.
            local cont = Container.getInfo(config.container_index)

            -- when backpack is not opened return.
            if table.count(cont) < 2 then 

                --- show error
                print("Drop Items: container index " .. config.container_index .. " is closed.")

                -- return
                return

            end    

            -- check if there are items to drop
            local item = Container.FindItem(config.items, config.container_index)

            -- when is item
            if table.count(item) > 1 then

                -- drop items to ground with random delay 500-700 ms
                Self.DropItem(config.pos.x, config.pos.y, config.pos.z, item.id, item.count, math.random(500, 700))

            else    

                -- when disabled opening next cont
                if not config.open_next_bp then return end

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
                if not isNewCont then return end

            end

        end

    end

end

-- call function
Walker.onLabel("signal")