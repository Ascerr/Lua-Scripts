--[[
    Script Name: 		Switch Life Ring and ROH 
    Description: 		Equip ROH when low mana and when high mana Life Ring.
    Author: 			Ascer - example
]]

local LIFE_RING = {on = 3089, off = 3052}           -- set id for life ring on - equiped, off - not
local RING_OF_HEALING = {on = 3098, off = 3061}     -- set id for ring of healing on - equiped, off - not
local MANA = {on = 700, off = 1100}                 -- if mana below ON value equip roh and life ring when mana above OFF.

-- DON'T EDIT BELOW THIS LINE 

Module.New("Switch Life Ring and ROH ", function ()
    
    -- when connected
    if Self.isConnected() then

        -- load mana
        local mp = Self.Mana()

        -- when mana
        if mp <= MANA.on then    
        
            -- when our slot.ring.id is different than RING_OF_HEALING.on
            if Self.Ring().id ~= RING_OF_HEALING.on then

                -- equip ring with 0 delay.
                Self.EquipItem(SLOT_RING, RING_OF_HEALING.off, 1, 0)

            end

        else

            -- load ring
            local ring = Self.Ring().id

            -- when mana is above off roh or no ring 
            if mp > MANA.off or ring == 0 then

                -- when our slot.ring.id is different than life_ring.on
                if ring ~= LIFE_RING.on then

                    -- equip ring 0 delay.
                    Self.EquipItem(SLOT_RING, LIFE_RING.off, 1, 0)

                end

            end

        end    

    end         

end)
