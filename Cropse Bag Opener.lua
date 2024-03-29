--[[
    Script Name: 		Cropse Bag Opener
    Description: 		Open bag inside dead cropse.
    Author: 			Ascer - example
]]

local BAG_ID = 2853 -- id of bag to open
local CROPSE = {"The", "Demonic", "Dead", "Slain", "Dissolved", "Remains", "Elemental", "Split", "Pile", "Monster", "loot", "Giant", "Lifeless", "Fallen"} -- names od dead cropses, add your if list no contains enough
local OPEN_IF_NOT_FOUND_ITEMS = {3031, 3492} -- open only if this items not found, need to be set to give Rifbot.looter time to collect items.


-- DON'T EDIT BELOW THIS LINE

function getCropse(name)

    -- in loop for all cropse names.
    for _, element in ipairs(table.lower(CROPSE)) do
        if string.lower(name):find(element) then
            return true
        end
    end

    return false

end   

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

end 


Module.New("Cropse Bag Opener", function ()

    -- load items inside all containers
    local containers = Container.getItems()

    -- in loop check for cropse
    for i, container in ipairs(containers) do
        
        -- load info about container.
        local contInfo = Container.getInfo(container.index)

        -- check for container name if contains dead cropse words.
        if getCropse(contInfo.name) then

            -- load items of containers.
            local items = container.items

            -- load bag
            local bag = isItem(items, BAG_ID) 

            -- when bag is inside dead cropse
            if table.count(bag) > 1 then

                -- check if all items are already collected.
                if not isItem(items, OPEN_IF_NOT_FOUND_ITEMS) then

                    -- finally open bag.
                    return Container.UseItem(container.index, bag.slot, bag.id, false, 500)

                end

            end
            
        end
                    
    end

    -- delay we loop whole module.
    mod:Delay(400, 800)

end)
