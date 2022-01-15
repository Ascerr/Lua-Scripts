--[[
    Script Name:        On Off Life Ring depent on Position
    Description:        Equip Life ring when you are example outside house and dequip if enter.
    Author:             Ascer - example
]]

local LIFE_RING = {on = 3089, off = 3052}       -- set id for life ring on - equiped, off - not
local POSITIONS = {                             -- when your character stay on some of this pos then dequip (off) life ring to backpack
    {x = 32333, y = 32234, z = 7},
    {x = 32334, y = 32234, z = 7}
}

-- DONT EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       isOnPos()
--> Description:    Check if your character is on one from table positions.

--> Return:         boolean true or false.      
----------------------------------------------------------------------------------------------------------------------------------------------------------
function isOnPos()
    local me = Self.Position()
    for i, pos in ipairs(POSITIONS) do
        if pos.x == me.x and pos.y == me.y and pos.z == me.z then return true end
    end
    return false    
end    

-- loop function
Module.New("On Off Life Ring depent on Position", function ()
    
    -- when connected to game
    if Self.isConnected() then
        
        -- not on pos
        if not isOnPos() then
        
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
