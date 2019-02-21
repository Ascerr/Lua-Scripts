--[[
    Script Name: 		Stack Items
    Description: 		Stacks items in container
    Author: 			Ascer - example
]]

local ITEMS = {3031, 3447}              -- items to stack
local MAIN_DELAY = {300, 700}           -- delay moving items

-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       stackItems()
--> Description:    Stack items in container. Will break after action.
--> Class:          None
--> Params:         None
-->                 
--> Return:         boolean true or false     
----------------------------------------------------------------------------------------------------------------------------------------------------------
function stackItems()
    local conts = Container.getItems()
    for j = 1, table.count(conts) do
        local stacks = {}
        local cont = conts[j]
        local items = cont.items
        local index = 0
        for i = 1, table.count(items) do
            index = index + 1
            local item = items[i]
            if table.find(ITEMS, item.id) then
                if item.count < 100 then
                    if not table.find(stacks, item.id) then
                        table.insert(stacks, item.id)
                        table.insert(stacks, {index - 1, item.id, item.count})
                    else
                        local remove_index = - 1
                        for k = 1, table.count(stacks) do
                            local stack = stacks[k]
                            if type(stack) == "table" then
                                if stack[2] == item.id then
                                    local space = 100 - stack[3]
                                    if item.count > space then
                                        return Container.MoveItemToContainer(cont.index, index - 1, cont.index, stack[1], item.id, space, 200)
                                    else    
                                        index = index - 1
                                        return Container.MoveItemToContainer(cont.index, index, cont.index, stack[1], item.id, item.count, 200)
                                    end
                                end
                            end                                      
                        end
                        if remove_index ~= -1 then
                            table.remove(stacks, remove_index)
                            table.remove(stacks, remove_index)
                        end
                    end
                end
            end                
        end    
    end
    return false
end

-- Module to run our function stackItems
Module.New("Stack Items", function (mod)
    stackItems()
    mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- delay
end)
