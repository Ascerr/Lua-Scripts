--[[
    Script Name: 		Switch Ering
    Description: 		Equip energy ring when when hpperc <= 75% with possiblity to off when high hpperc value.
    Author: 			Ascer - example
]]

local ENERGY_RING = {on = 3088, off = 3051}                             -- set id for ering on - equiped, off - not
local HPPERC = 75							                            -- when hpperc below or equal rquip ring else dequip
local ONLY_WHEN_NO_PLAYERS_ON_SCREEN = false                            -- true/false will ering when low hp but also when no players on screen.
local DEQUIP_ONLY_WHEN_HPPERC_ABOVE = {enabled = false, hpperc = 95}    -- true/false dequip e ring only when hpperc will above value.

function getPlayers()
    for _, player in ipairs(Creature.iPlayers(7, false)) do
        return 1
    end
    return 0    
end    
 
Module.New("Switch Ering", function (mod)
    local hp = Self.HealthPercent()
    local ring = Self.Ring()
    local players = 0
    if hp <= HPPERC then
        if ONLY_WHEN_NO_PLAYERS_ON_SCREEN then
            players = getPlayers()
        end
        if players > 0 then return end     
        if ring.id ~= ENERGY_RING.on then
            Self.EquipItem(SLOT_RING, ENERGY_RING.off, 1)
        end
    else
        if ring.id == ENERGY_RING.on and (not DEQUIP_ONLY_WHEN_HPPERC_ABOVE.enabled or (DEQUIP_ONLY_WHEN_HPPERC_ABOVE.enabled and hp >= DEQUIP_ONLY_WHEN_HPPERC_ABOVE.hpperc)) then
            Self.DequipItem(SLOT_RING) -- dequip ring
        end
    end
    mod:Delay(200, 700)
end)
