--[[
    Script Name: 		Reconnect Backpacks
    Description: 		Open backpacks after relogin.
    Author: 			Ascer - example
]]

local BACKPACKS_IDS = {2854, 2853}  -- backpacks id 
local AMOUNT = 3                    -- amount of backpacks to open.

-- DON'T EDIT BELOW THIS LINE

local loop, open, slots, lastAmount = 0, false, {}, 0

Module.New("Reconect Backpacks", function ()
    if Self.isConnected() then
        if open and os.clock() - loop > 1 then
            local items = Container.getItems() -- load table with items
            local bps = table.count(items) -- load amount od opened backpacks
            if bps == AMOUNT then 
                open = false -- set open on false all backpacks are open already.
            else
                if bps == 0 then -- when no backpack opened start with opening main from equipment.
                    Self.OpenMainBackpack()
                    loop = os.clock()
                else
                    for i, cont in pairs(items) do -- search for all conts.
                        local contItems = cont.items
                        local contIndex = cont.index
                        if contIndex == 0 then -- we opening backpack only from index 0 {first open}
                            for j = 1, #contItems do
                                local item = contItems[j]
                                local slot = (j - 1)
                                if table.find(BACKPACKS_IDS, item.id) then
                                    if lastAmount < bps + 1 then
                                        table.remove(slots, table.count(slots) - 1)
                                    end    
                                    if not table.find(slots, slot) then
                                        Container.UseItem(contIndex, slot, item.id, true)
                                        table.insert(slots, slot)
                                        lastAmount = bps + 1
                                        loop = os.clock()
                                        break -- end loop 
                                    end
                                end     
                            end
                        end    
                    end
                end
            end               
        end    
    else
        open = true -- set open on true to start reconnect after relogin 
        slots = {} -- reset internal variables
        lastAmount = 0
    end    
end)