--[[
    Script Name:        Open Next Bp for Runes.
    Description:        Open next backpack in specific container index when all no more runes..
    Author:             Ascer - example
]]


-- DONT EDIT BELOW THIS LINE

local BACKPACK = {index = 0, contid = 4387, runeid = 2273}          -- [index] container nr where we looking for runes, [contid] = id of backpack next to open, [runeid] = rune we search for

-- loop module
Module.New("Open Next Bp for Runes", function (mod)

    -- when connected.
    if Self.isConnected() then

        -- search for runes.
        local item = Container.FindItem(BACKPACK.runeid, BACKPACK.index)

        -- if not found
        if not item then

            -- search for next backpack
            item = Container.FindItem(BACKPACK.contid, BACKPACK.index)

            -- if found
            if item ~= false then

                -- open backpack
                Container.UseItem(item.index, item.slot, item.id, false, 1000)

            end    

        end 

    end    

    -- delay between actions in miliseconds
    mod:Delay(200, 500)

end)