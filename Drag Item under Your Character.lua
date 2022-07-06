--[[
    Script Name:        Drag Item under Your Character
    Description:        Dragging items around you 1 sqm to your character position
    Author:             Ascer - example
]]

local config = {
   items = {3031, 3492} -- items to drag
}


-- DON'T EDIT BELOW THIS LINE

Module.New(" Drag Item under Your Character", function ()
    
    -- when connected
    if Self.isConnected() then

        -- load self position
        local pos = Self.Position()

        -- in loop load items around you
        for x = -1, 1 do
            
            for y = -1, 1 do
                
                -- load item on map
                local map = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)

                -- when on map there is item and there is no your char position
                if (pos.x ~= 0 or pos.y ~= 0) and table.find(config.items, map.id) then

                    -- move item to your char pos.
                    Map.MoveItem(pos.x + x, pos.y + y, pos.z, pos.x, pos.y, pos.z, map.id, map.count, 0) -- 0 is delay in ms.

                end 

            end

        end        

    end 

end)
