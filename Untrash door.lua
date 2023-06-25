--[[
    Script Name:        Untrash door
    Description:        Throw out to dustbin items from door expect "allow_ids"
    Author:             Ascer - example
]]

local door = {x = 32334, y = 32234, z = 7}      -- position of door on map
local dustbin = {x = 32335, y = 32234, z = 7}   -- position of dustbin on map
local allow_ids = {99, 1630}                     -- put here ids to don't throw // 99 - id of alive creatures, 1630 or other is opened door id.
local delay = 500                               -- move items every this time in miliseconds

-- DON'T EDIT BELOW THIS LINE

-- moduke
Module.New("Untrash door", function()
    if Self.DistanceFromPosition(door.x, door.y, door.z) <= 7 then
        local map = Map.GetTopMoveItem(door.x, door.y, door.z)
        if not table.find(allow_ids, map.id) then
            Map.MoveItem(door.x, door.y, door.z, dustbin.x, dustbin.y, dustbin.z, map.id, map.count, delay) -- throwing items to dustbin
        end 
    end    
end)