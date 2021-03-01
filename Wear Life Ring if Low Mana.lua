--[[
    Script Name: 		Wear Life Ring if Low Mana
    Description: 		Equip Life ring when mana % below value else dequip.
    Author: 			Ascer - example
]]

local MANA_PERC = 50                            -- wear ring below this value else dequip
local LIFE_RING = {on = 3089, off = 3052}       -- set id for life ring on - equiped, off - not

-- DONT EDIT BELOW THIS LINE

Module.New("Wear Life Ring if Low Mana", function ()
    
    -- when connected to game
    if Self.isConnected() then
        
        -- when low mana
        if Self.ManaPercent() <= MANA_PERC then
        
            -- when our slot.ring.id is different than life_ring.on
            if Self.Ring().id ~= LIFE_RING.on then

                -- equip ring 0 delay.
                Self.EquipItem(SLOT_RING, LIFE_RING.off, 1, 0)

            end

        else 

            -- when our slot.ring.id is this same as life ring on
            if Self.Ring().id == LIFE_RING.on then

                -- dequip ring.
                Self.DequipItem(SLOT_RING)

            end

        end 

    end 

end)
