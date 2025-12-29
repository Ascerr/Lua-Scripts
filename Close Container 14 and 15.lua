--[[
    Script Name:        Close Container 14 and 15
    Description:        Max opened containers limit for most of tibia server is 16 (index 0-15) so you will expect bugs in this case script will close selected containers indexs if they opened more than 5s (enough to pickup loot)
    Author:             Ascer - example
]]

local POSSIBLE_INDEXS = {14, 15}                        -- containers indexs to close // remember containers index is 0-15 so last ones will 14 and 15
local DELAY = 5000                                      -- close only if opened more than 5000ms (5s)
local IGNORE_NAMES = {"backpack"}                       -- even if container is on specified index don't close if name container "backpack"


-- DON'T EDIT BELOW THIS LINE

local orderList = {}
IGNORE_NAMES = table.lower(IGNORE_NAMES)

function isContainerInOrderList(index)
    for i, cont in ipairs(orderList) do
        if cont.index == index then 
            return true, cont, i
        end 
    end
    return false, nil, -1   
end --> return @bool (true/false) is container / @table of container / @number index of item in table.

function containerMatchName(str)
    for i = 1, #IGNORE_NAMES do
        if string.find(string.lower(IGNORE_NAMES[i]), string.lower(str)) then
            return true
        end    
    end
    return false    
end --> return true/false if found container name

function orderContainers()
    for i = 1, #POSSIBLE_INDEXS do
        local cont = Container.getInfo(POSSIBLE_INDEXS[i])
        if table.count(cont) > 1 then
            local isC, c, iC = isContainerInOrderList(POSSIBLE_INDEXS[i])
            if not isC then
                if not containerMatchName(cont.name) then
                    return table.insert(orderList, {index = POSSIBLE_INDEXS[i], name = cont.name, time = os.clock()})
                end        
            else    
                if table.count(c) > 0 then
                    if os.clock() - c.time >= (DELAY/1000) then
                        if not containerMatchName(cont.name) then Container.Close(c.index, 0) end
                        return table.remove(orderList, iC)
                    end 
                end 
            end 
        end 
    end 

end 

Module.New("Close Container 15 and 16", function()
    orderContainers()
end)
