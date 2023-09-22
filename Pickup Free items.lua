--[[
    Script Name:        Pickup Free items
    Description:        Pickup free items around your character to selected container index
    Author:             Ascer - example
]]

local FREE_ITEMS = {3031, 3447, 3160}                       -- IDs of items to pickup
local CONTAINER_INDEX = 0                                   -- container number to pickup items 0 - first opened backapck, 1 - second opened etc.
local OPEN_NEXT_BP_IF_FULL = {enabled = true, id = 2854}    -- open next backpack: enabled - true/false, 
local ALLOW_PICKUP_COVERED_ITEMS = false                    -- when item is covered by some trash up move it under yourself to pickup. 

-- DON'T EDIT BELOW

Module.New("Pickup Free items", function ()

    if Self.isConnected() then
        
        -- load self pos.
        local pos = Self.Position()

        -- in range for 1 sqm
        for x = -1, 1 do

            for y = -1 , 1 do
                
                -- load map
                local map = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)

                -- when we found item
                if table.find(FREE_ITEMS, map.id) then

                    -- load pickup bp
                    local pickupCont = Container.getInfo(CONTAINER_INDEX)

                    -- when found bp
                    if table.count(pickupCont) > 1 then

                        -- when backpack is full
                        if pickupCont.amount >= pickupCont.size then

                            -- when able open next bp
                            if OPEN_NEXT_BP_IF_FULL.enabled then
                            
                                -- open next backpack
                                Container.Open(CONTAINER_INDEX, OPEN_NEXT_BP_IF_FULL.id, false, 1000)

                            else    

                                -- show info about no more space
                                print("Pickup container is full.")

                            end  

                            -- break loop
                            break    

                        else    

                            -- Pickup item
                            Self.PickupItem(pos.x + x, pos.y + y, pos.z, map.id, map.count, CONTAINER_INDEX, pickupCont.amount, 0)

                        end    

                    else

                        -- show info about closed container
                        print("Container index (" .. CONTAINER_INDEX ..") to pickup items is closed.")

                    end    

                    -- break loop
                    break

                else
                
                    -- when we can picking covered items
                    if ALLOW_PICKUP_COVERED_ITEMS then

                        -- load items ground.
                        local items = Map.GetItems(pos.x + x, pos.y + y, pos.z)

                        -- inside loop check if there is searched item
                        for i, item in ipairs(items) do

                            -- if there is item
                            if table.find(FREE_ITEMS, item.id) then

                                -- when position is different than my current
                                if x ~= 0 or y ~= 0 then

                                    -- move item under your character
                                    Map.MoveItem(pos.x + x, pos.y + y, pos.z, pos.x, pos.y, pos.z, map.id, map.count, 0)

                                    break

                                end    

                            end

                        end    

                    end    

                end 

            end
            
        end     
    end

end) 
