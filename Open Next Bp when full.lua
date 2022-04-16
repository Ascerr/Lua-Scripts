--[[
    Script Name:        Open Next Bp when full
    Description:        Open next backpack in specific container when all slots taken.
    Author:             Ascer - example
]]

local BACKPACKS = {
    {index = 0, id = 2854},     -- container index 0 = first opened container, id - backpack id to open.
    {index = 1, id = 2854}
    -- you can add more here
}

-- DONT EDIT BELOW THIS LINE

-- loop module
Module.New("Open Next Bp when full", function (mod)

    -- when connected.
    if Self.isConnected() then

        -- inside loop
        for i, bp in ipairs(BACKPACKS) do

            -- load container with index: BACKPACK.index
            local cont = Container.getInfo(bp.index)

            -- when amount of items in table is above 0
            if table.count(cont) > 0 then

                -- when amount of items == size of cont.
                if cont.amount == cont.size then

                    -- searach for next backpack to open.
                    local item = Container.FindItem(bp.id, bp.index)

                    -- if found
                    if item ~= false then
     
                        -- open backpack
                        Container.UseItem(item.index, item.slot, item.id, false, 1000)

                    end 

                end    

            end

        end    
            
    end    

    -- delay between actions in miliseconds
    mod:Delay(200, 500)

end)
