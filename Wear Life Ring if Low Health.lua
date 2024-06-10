--[[
    Script Name: 		Wear Life Ring if Low Health
    Description: 		Equip Life ring when health % below value else dequip.
    Author: 			Ascer - example
]]

local HEALTH_PERC = {on = 50, off = 90}         -- wear ring when hpperc is below (ON value) and dequip when will be above (OFF value)
local LIFE_RING = {on = 3089, off = 3052}       -- set id for life ring on - equiped, off - not

-- DONT EDIT BELOW THIS LINE

Module.New("Wear Life Ring if Low Health", function ()
    
    -- when connected to game
    if Self.isConnected() then
        	
        -- load ring and hpperc
    	local hpperc = Self.HealthPercent()
    	local ring = Self.Ring()

        -- when low health
        if hpperc <= HEALTH_PERC.on then
        
            -- when our slot.ring.id is different than life_ring.on
            if Self.Ring().id ~= LIFE_RING.on then

                -- equip ring 0 delay.
                Self.EquipItem(SLOT_RING, LIFE_RING.off, 1, 0)

            end

        -- when hpperc is above max value.
        elseif hpperc >= HEALTH_PERC.off then

            -- when our slot.ring.id is this same as life ring on
            if Self.Ring().id == LIFE_RING.on then

                -- dequip ring.
                Self.DequipItem(SLOT_RING)

            end

        end 

    end 

end)
