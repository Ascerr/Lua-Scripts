--[[
    Script Name: 		Switch Life Ring and ROH 
    Description: 		Equip ROH when low mana and when high mana Life Ring.
    Author: 			Ascer - example
]]

local LIFE_RING = {on = 3089, off = 3052}           -- set id for life ring on - equiped, off - not
local RING_OF_HEALING = {on = 3098, off = 3061}     -- set id for ring of healing on - equiped, off - not
local MANA = 700                                    -- if mana below this value equip roh else life ring.

-- DON'T EDIT BELOW THIS LINE 

Module.New("Switch Life Ring and ROH ", function ()
    
    -- when connected
    if Self.isConnected() then

        -- when mana
        if Self.Mana() <= MANA then    
        
            -- when our slot.ring.id is different than RING_OF_HEALING.on
            if Self.Ring().id ~= RING_OF_HEALING.on then

                -- equip ring with 0 delay.
                Self.EquipItem(SLOT_RING, RING_OF_HEALING.off, 1, 0)

            end

        else

            -- when our slot.ring.id is different than life_ring.on
            if Self.Ring().id ~= LIFE_RING.on then

                -- equip ring 0 delay.
                Self.EquipItem(SLOT_RING, LIFE_RING.off, 1, 0)

            end

        end    

    end         

end)
