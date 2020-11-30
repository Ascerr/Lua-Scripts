--[[
    Script Name:        Open Next Bp when full
    Description:        Open next backpack in specific container when all slots taken.
    Author:             Ascer - example
]]


-- DONT EDIT BELOW THIS LINE
local BACKPACK = {index = 0, id = 2853}

-- loop module
Module.New("Open Next Bp when full", function (mod)

    -- when connected.
    if Self.isConnected() then

        -- load container with index: BACKPACK.index
        local cont = Container.getInfo(BACKPACK.index)

        -- when amount of items in table is above 0
        if table.count(cont) > 0 then

            -- when amount of items == size of cont.
            if cont.amount == cont.size then

                -- searach for next backpack to open.
                local item = Container.FindItem(BACKPACK.id, BACKPACK.index)

                -- if found
                if item ~= false then
 
                    -- open backpack
                    Container.UseItem(item.index, item.slot, item.id, false, 1000)

                end 

            end    

        end

    end    

    -- delay between actions in miliseconds
    mod:Delay(200, 500)

end)