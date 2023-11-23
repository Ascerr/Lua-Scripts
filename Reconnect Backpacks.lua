--[[
    Script Name: 		Reconnect Backpacks
    Description: 		Open backpacks after relogin.
    Author: 			Ascer - example
]]

local config = {
    backpacks = {2853, 2853, 3503},     -- backpacks id, bot will start opening from frist container slot
    amount = 3,                         -- amount to open
    active_on_script_startup = true,    -- re-open bps on script startup
    minimize = {
        enabled = false,                                                 -- true/false minimize 
        first_container_minimize_button_pos = {x = 1336, y = 356},       -- position of first container minimize button (x, y). You can check this executing this lua: Module.New("check mouse pos", function() local mouse = Rifbot.GetMousePos() print("x = " .. mouse.x .. ", y = " .. mouse.y) end)
        offset = 20                                                      -- difference between position y in next container button, pos x is always this same.
    }    
}

-- DON'T EDIT BELOW THIS LINE

local loop, open, slots, lastAmount, close, reactivateLooter, disconectTime, opening, lastMinimized = 0, false, {}, 0, false, false, 0, false, -1

if config.active_on_script_startup then
    open = true
    close = true
end    

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

            if config.minimize.enabled then

                if bps > lastAmount and lastMinimized ~= lastAmount then

                    -- left click (we adding + 20 due some error in mouse pos connected with game window bar)
                    Rifbot.MouseClick(config.minimize.first_container_minimize_button_pos.x, config.minimize.first_container_minimize_button_pos.y + (config.minimize.offset * lastAmount) + 20)
                    lastMinimized = lastAmount

                end 

            end    
            
            -- when amout of backpack is equal our target break
            if bps == config.amount then 

                -- set open on false all backpacks are open already.
                open = false 

                lastMinimized = -1

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
                                            lastAmount = bps
                                            loop = os.clock()

                                            opening = true
                                            
                                            -- end loop
                                            break

                                        else
                                                                                    

                                            if bps == (lastAmount + 1) then
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
        lastMinimized = -1
        opening = false
        Looter.Enabled(false) -- disable looter
        disconectTime = os.clock()
    end    
end)


--> here you can check pos of mouse on screen
--Module.New("check mouse pos", function() local mouse = Rifbot.GetMousePos() print("x = " .. mouse.x .. ", y = " .. mouse.y) end)
