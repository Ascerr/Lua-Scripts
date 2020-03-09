--[[
    Script Name: 		Switch Life Axe Ring
    Description: 		Equip Life ring when no monsters in range else equip axe ring to increase dmg.
    Author: 			Ascer - example
]]

local LIFE_RING = {on = 3089, off = 3052}       -- set id for life ring on - equiped, off - not
local AXE_RING = {on = 3095, off = 3092}        -- set id for axe ring on - equiped, off - not
local MONSTERS = {"Dragon", "Dragon Lord", "Rat"}        -- set monsters names with Capital letter.
local RANGE = 2                                 -- equip ring when moster distance sqm.

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getMonsters(mobs, range)
--> Description:    Calculate monsters in range.
--> Class:          None
--> Params:
-->                 @mobs - table with monsters names, capital letter.
-->                 @range - number distance between monster and your character.
-->                 
--> Return:         boolean true or false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters(mobs, range)

    -- inside loop for monsters on screen.
    for i, mob in pairs(Creature.iMonsters(range, false)) do 

        -- when monster name is valid.
        if table.find(mobs, mob.name) then

            -- when creature is alive.
            if mob.hpperc > 0 then 

                -- return true
                return true

            end 

        end    

    end 

    -- return false monsters not found.
    return false

end    


Module.New("Switch Life Axe Ring", function ()
    
    -- when monsters around.
    if getMonsters(MONSTERS, RANGE) then

        -- when our slot.ring.id is different than axe_ring.on
        if Self.Ring().id ~= AXE_RING.on then

            -- equip ring with 0 delay.
            Self.EquipItem(SLOT_RING, AXE_RING.off, 1, 0)

        end
        
    else
        
        -- when our slot.ring.id is different than life_ring.on
        if Self.Ring().id ~= LIFE_RING.on then

            -- equip ring 0 delay.
            Self.EquipItem(SLOT_RING, LIFE_RING.off, 1, 0)

        end

    end         

end)
