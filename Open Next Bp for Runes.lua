--[[
    Script Name:        Open Next Bp for Runes.
    Description:        Open next backpack in specific container index when all no more runes..
    Author:             Ascer - example
]]


-- DONT EDIT BELOW THIS LINE

local BACKPACK = {index = 0, runeid = 2273}          -- [index] container nr where we looking for runes, [runeid] = rune we search for

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       openNextContainerFromIndex
--> Description:    Open any container from index (nr)
--> Params:         
-->                 @nr - number container index
--> Return:         boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function openNextContainerFromIndex(nr)
    local items = Container.getItems(nr)
    for i, item in ipairs(items) do
        if Item.hasAttribute(item.id, ITEM_FLAG_CONTAINER) then
            return Container.UseItem(nr, i - 1, item.id, false, math.random(500, 700))
        end 
    end 
end

-- loop module
Module.New("Open Next Bp for Runes", function (mod)

    -- when connected.
    if Self.isConnected() then

        -- search for runes.
        local item = Container.FindItem(BACKPACK.runeid, BACKPACK.index)

        -- if not found
        if not item then

            -- open any empty container of index.
            openNextContainerFromIndex(BACKPACK.index)

        end 

    end    

    -- delay between actions in miliseconds
    mod:Delay(200, 500)

end)
