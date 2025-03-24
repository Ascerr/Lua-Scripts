--[[
    Script Name:        [on label] Withdraw mana fluids from ground
    Description:        When character in walker reach label "withdraw" then it will open ground container on pos x, y, z and withdraw confing.amount (without checking current amount). 
    Author:             Ascer - example
]]

local config = {
    label_name = "withdraw",                -- do this action on this current label in walker.
    container_id = 2868,                    -- id of bag/backpack lay on ground. Should be different than other you carry on. All backpacks in this container should be this same.
    pos = {x = 32354, y = 32231, z = 5},    -- position where lay bag/backpack on ground.
    container_index = 0,                    -- pickup to this container index (default = 0 first opened backpack)
    amount = 25,                            -- amount fluids to withdraw
    
    --> delays {optional change}
    moveItemsDelay = 200,                   -- delay in miliseconds move items
    openBpDelay = 800,                      -- delay in miliseconds open container
}

-- DONT EDIT BELOW THIS LINE

local withdrawedAmount, savedItemsAmount = 0, -1

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getCont(id)
--> Description:    Read for container id  
--> Params:         
-->                 @id number 0-15
--> 
--> Return:         on fail return -1, -1,  else return index, container table = {id = ?, name = ?, size = ?, amount = ?}   
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCont(id)
    for i = 0, 15 do
        local cont = Container.getInfo(i)
        if table.count(cont) > 1 then
            if cont.id == id then
                return i, cont
            end 
        end 
    end
    return -1, -1   
end 

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       withdrawMF()
--> Description:    Withdraw MF from ground container based on script config.
--> Params:         None
--> 
--> Return:         boolean true if completed or false if function working..   
----------------------------------------------------------------------------------------------------------------------------------------------------------
function withdrawMF()
    local index, bag = getCont(config.container_id)
    if bag == -1 then
        Map.UseItem(config.pos.x, config.pos.y, config.pos.z, config.container_id, 1, config.openBpDelay)
    else
        local items = Container.getItems(index)
        for i, item in ipairs(items) do
            if item.id == MANA_FLUID.id then
                if MANA_FLUID.type ~= 0 or (MANA_FLUID.type == 0 and item.count == MANA_FLUID.count) then
                    local dest = Container.getInfo(config.container_index)

                    -- check if destination bp index is open
                    if table.count(dest) < 3 then return print("Destination backpack index is closed.") end
                    
                    -- open next bp destination bp to pack fluids
                    if dest.size == dest.amount then
                        
                        -- save withdrawed items before open next dest container
                        if savedItemsAmount ~= -1 then
                            local lastWithdrawAmount = Self.ItemCount(MANA_FLUID.id, config.container_index) - savedItemsAmount
                            withdrawedAmount = withdrawedAmount + lastWithdrawAmount 
                            savedItemsAmount = -1
                        end    
                        local destItems = Container.getItems(config.container_index)
                        for j, destItem in ipairs(destItems) do
                            if destItem.id == dest.id then
                                Container.UseItem(config.container_index, j - 1, destItem.id, false, config.openBpDelay)
                                return false
                            end    
                        end    
                        withdrawedAmount = 0
                        savedItemsAmount = -1
                        -- return true break label loop due fact we don't have more space to pack fluids
                        return true
                    else
                        if withdrawedAmount < config.amount then
                            if savedItemsAmount == -1 then
                                savedItemsAmount = Self.ItemCount(MANA_FLUID.id, config.container_index)
                                
                                -- withdraw to destination bp amount depend on mana_fluid.type
                                if MANA_FLUID.type == 0 then
                                    Container.MoveItemToContainer(index, i - 1, config.container_index, dest.amount, item.id, 1, config.moveItemsDelay)
                                    return false
                                else
                                    local toPcikup = (config.amount - withdrawedAmount)
                                    if item.count < toPcikup then
                                        toPcikup = item.count
                                    end    
                                    Container.MoveItemToContainer(index, i - 1, config.container_index, dest.amount, item.id, toPcikup, config.moveItemsDelay)
                                    return false
                                end    
                            else
                                
                                -- calcualte withdrawed amount
                                local lastWithdrawAmount = Self.ItemCount(MANA_FLUID.id, config.container_index) - savedItemsAmount
                                withdrawedAmount = withdrawedAmount + lastWithdrawAmount 
                                savedItemsAmount = -1
                                return false
                            end    
                        else
                            withdrawedAmount = 0
                            savedItemsAmount = -1
                            return true
                        end    
                    end    
                end
            end
        end

        -- open next bp from source container to withdraw more mfs
        for i, item in ipairs(items) do
            if item.id == config.container_id then
                Container.UseItem(index, i - 1, item.id, false, config.openBpDelay)
                return false
            end
        end
        withdrawedAmount = 0
        savedItemsAmount = -1    

        -- no more fluids found in source bp break walker label loop
        return true                         
    end    
end    

-- label function
function signal(label)
    if label == config.label_name then
        while true do
            -- wait to prevent program hangs.
            wait()
            local ret  = withdrawMF()
            if ret then return true end
        end   
   end   
end
Walker.onLabel("signal")            
