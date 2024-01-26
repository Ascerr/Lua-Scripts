--[[
    Script Name: 		Switch Ering
    Description: 		Equip energy ring when when hpperc <= 75% else dquip to first open container.
    Author: 			Ascer - example
]]

local ENERGY_RING = {on = 3088, off = 3051}     -- set id for ering on - equiped, off - not
local HPPERC = 75							    -- when hpperc below or equal rquip ring else dequip
local ONLY_WHEN_NO_PLAYERS_ON_SCREEN = false    -- true/false will ering when low hp but also when no players on screen.


function getPlayers()
    for _, player in ipairs(Creature.iPlayers(7, false)) do
        return 1
    end
    return 0    
end    
 
Module.New("Switch Ering", function (mod)
    local hp = Self.HealthPercent()
    local ring = Self.Ring()
    if hp <= HPPERC then
        if ONLY_WHEN_NO_PLAYERS_ON_SCREEN then
            local players = getPlayers()
        else
            local players = 0
        end
        if players > 0 then return end     
        if ring.id ~= ENERGY_RING.on then
            Self.EquipItem(SLOT_RING, ENERGY_RING.off, 1)
        end
    else
        if ring.id == ENERGY_RING.on then
            Self.DequipItem(SLOT_RING, SLOT_AMMO, 1) -- dequip ring
            --Self.EquipItem(SLOT_RING, 3052, 1)
        end
    end
    mod:Delay(200, 700)
end)
