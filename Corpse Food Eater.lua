--[[
    Script Name: 		Corpse Food Eater
    Description: 		Force eat food inside corpse of monsters
    Author: 			Ascer - example
]]

local FOOD_ID = {3607} -- ID of food to eat, add your if need
local CROPSE = {"The", "Demonic", "Dead", "Slain", "Dissolved", "Remains", "Elemental", "Split", "Pile", "Monster", "loot", "Giant", "Lifeless", "Fallen"} -- names od dead cropses, add your if list no contains enough
local DELAY = 1 -- 1s between potential food eat tries

-- DON'T EDIT BELOW THIS LINE

local eatTime = 0

function getCropse(name)
    for _, element in ipairs(table.lower(CROPSE)) do
        if string.lower(name):find(element) then
            return true
        end
    end
    return false
end --> returns true/false if container match to corpse names  

function isItem(array, item)
    if type(item) ~= "table" then
        item = {item}
    end
    for i,element in ipairs(array) do
        if table.find(item, element.id) then
            return {id = element.id, count = element.count, slot = (i - 1)}
        end    
    end    
    return false
end --> returns array with searched item or false if not found

-- main module
Module.New("Cropse Bag Opener", function ()
    if Self.isConnected() then
        if os.clock() - eatTime >= DELAY then
            local containers = Container.getItems()
            for i, container in ipairs(containers) do
                local contInfo = Container.getInfo(container.index)
                if getCropse(contInfo.name) then
                    local items = container.items
                    local food = isItem(items, FOOD_ID) 
                    if table.count(food) > 1 then
                        eatTime = os.clock()
                        return Self.UseItem(food.id, false, 0)
                    end
                end          
            end
        end 
    end    
end)