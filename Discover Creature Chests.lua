--[[
    Script Name:        Discover Creature Chests
    Description:        When you found creature chests on map, send pm to some ppls about position of chest.
    Author:             Ascer - example
]]


local chests = {"Common Cursed Chest", "Rare Cursed Chest", "Epic Cursed Chest", "Legendary Cursed Chest"} -- chest names
local receivers = {"Tom", "Kit", "Mat"} -- receivers names


-- DON'T EDIT BELOW THIS LINE
local chests = table.lower(chests)
local storage = {}

function foundInStorage(x, y, z)
    for _, pos in ipairs(storage) do
        if pos.x == x and pos.y == y and pos.z == z then return true end
    end
    return false   
 end    

Module.New("Discover Creature Chests", function(mod)
    local me = Self.Position()
    for _, c in ipairs(Creature.iCreatures(7)) do
        if table.find(chests, string.lower(c.name)) and not foundInStorage(c.x, c.y, c.z) then
            for i = 1, #receivers do
                Self.PrivateMessage(receivers[i], "Found: " .. c.name .. " on pos: " .. c.x .. ", " .. c.y .. ", " .. c.z .. ".", 0)
            end
            table.insert(storage, {x = c.x, y = c.y, z = c.z})
        end     
    end    
    mod:Delay(500)        
end)