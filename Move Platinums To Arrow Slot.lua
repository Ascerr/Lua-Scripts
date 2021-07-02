--[[
    Script Name: 		Move Platinums To Arrow Slot
    Description: 		Stack platinum coins inside arrow (ammo) slot up to 100
    Author: 			Ascer - example
]]

local PLATINUM = 3035   -- id of platinum coins

-- DON'T EDIT BELOW THIS LINE

Module.New("Move Platinums To Arrow Slot", function (mod)

    -- when self connected.
    if Self.isConnected() then

        -- load arrow slot
        local arrow = Self.Ammo()
        
        -- when arrow id is different than platinum coins or count is below 100
        if arrow.id ~= PLATINUM or arrow.count < 100 then

            -- load platinum in containers
            local item = Container.FindItem(PLATINUM)
            
            -- when item found
            if item ~= false then
                
                -- set valid amount to move
                local toMove = item.count

                -- when count is above limit set new amount
                if toMove > (100 - arrow.count) then toMove = (100 - arrow.count) end

                -- shove to ammo slot
                Container.MoveItemToEquipment(item.index, item.slot, SLOT_AMMO, item.id, toMove) 

            end

        end

    end

    -- mod delay    
    mod:Delay(500, 1000)

end)