--[[
    Script Name:        Item on Screen Alert
    Description:        Play sound when item is detected on screen
    Author:             Ascer - example
]]

local ITEMS = {3031, 3492, 3160}                       -- IDs of items to detect


-- DON'T EDIT BELOW

Module.New("Item on Screen Alert", function ()
    if Self.isConnected() then
        local pos = Self.Position()
        for x = -7, 7 do
            for y = -5 , 5 do
                local map = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)
                if table.find(ITEMS, map.id) then
                    print("Found item id: " .. map.id .. " on pos: " .. pos.x + x .. ", " .. pos.y + y .. ", " .. pos.z)
                    Rifbot.PlaySound("Default.mp3")
                end 
            end
        end     
    end
    mod:Delay(500)
end) 