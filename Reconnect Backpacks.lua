--[[
    Script Name: 		Reconnect Backpacks
    Description: 		Open backpacks after relogin.
    Author: 			Ascer - example
]]

local config = {
    backpacks = {2867, 3503, 3503}, -- backpacks id, bot will start opening from frist container slot
    amount = 3                -- amount to open
}

-- DON'T EDIT BELOW THIS LINE

local loop, open, slots, lastAmount, close, reactivateLooter, disconectTime, opening = 0, false, {}, 0, false, false, 0, false

Module.New("Reconect Backpacks", function ()
    
    -- when connected
    if Self.isConnected() then
        
        -- if can chceck closeing
        if close and os.clock() - disconectTime > 0.5 then
            
            -- when found any container
            if Container.Amount() > 0 then
                
                -- destroy all containers
                for i = 0, 15 do
                    Container.Close(i, 0)
                end

            else
                
                -- set param on fale
                close = false

            end
                
        -- open new                 
        elseif not close and open and os.clock() - loop > 1 then

            -- load table with items
            local items = Container.getItems()
            
            -- load amount od opened backpacks
            local bps = Container.Amount()
            
            -- when amout of backpack is equal our target break
            if bps == config.amount then 

                -- set open on false all backpacks are open already.
                open = false 

                -- when enabling looter is active enable
                if reactivateLooter then 
                    Looter.Enabled(true) 
                    reactivateLooter = false
                end

            else
                
                -- when no backpack opened start with opening main from equipment.
                if bps == 0 then 
                    Self.OpenMainBackpack()
                    loop = os.clock()
                else
                    
                    -- search for all conts.
                    for i, cont in pairs(items) do 
                        
                        local contItems = cont.items
                        local contIndex = cont.index
                        
                        -- we opening backpack only from index 0 {first open}
                        if contIndex == 0 then 
                            for j = 1, #contItems do
                                
                                local item = contItems[j]
                                local slot = (j - 1)
                                
                                -- check for valid id.
                                if table.find(config.backpacks, item.id) then 
   
                                    if not table.find(slots, slot) then
                                        
                                        if not opening then
                                            
                                            -- open container in new slot
                                            Container.UseItem(contIndex, slot, item.id, true, 0) 
                                            lastAmount = bps + 1
                                            loop = os.clock()

                                            opening = true
                                            
                                            -- end loop
                                            break

                                        else
                                                                                    

                                            if bps == lastAmount then
                                                table.insert(slots, slot)   
                                            end

                                            opening = false

                                            break

                                        end     
                                    end
                                end     
                            end
                        end    
                    end
                end
            end 
        elseif not open then
            if Looter.isEnabled() then 
                reactivateLooter = true
            end    
        end    
    else
        close = true
        open = true -- set open on true to start reconnect after relogin 
        slots = {} -- reset internal variables
        lastAmount = 0
        opening = false
        Looter.Enabled(false) -- disable looter
        disconectTime = os.clock()
    end    
end)
