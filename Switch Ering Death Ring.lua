--[[
    Script Name: 		Switch Ering Death Ring
    Description: 		Equip energy ring when when hpperc <= 40% else equip death ring.
    Author: 			Ascer - example
]]

local ENERGY_RING = {on = 3088, off = 3051} -- set id for ering on - equiped, off - not
local DEATH_RING = 6299                     -- ID of ring to swirch
local HPPERC = 40							-- when hpperc below or equal rquip ring else dequip

Module.New("Switch Ering Death Ring", function ()
    local hp = Self.HealthPercent()
    local ring = Self.Ring()
    if hp <= HPPERC then
        if ring.id ~= ENERGY_RING.on then
            Self.EquipItem(SLOT_RING, ENERGY_RING.off, 1)
        end
    else
        if ring.id ~= DEATH_RING then
            Self.EquipItem(SLOT_RING, DEATH_RING, 1)
        end
    end
end)
