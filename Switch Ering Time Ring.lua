--[[
    Script Name: 		Switch Ering Time Ring
    Description: 		Equip energy ring when when hpperc <= 40% else equip time ring.
    Author: 			Ascer - example
]]

local ENERGY_RING = {on = 3088, off = 3051}     -- set id for ering on - equiped, off - not
local TIME_RING = {on = 3090, off = 3053}       -- set id for time ring on - equiped, off - not
local HPPERC = 40							    -- when hpperc below or equal equip e ring else wear time ring.

Module.New("Switch Ering Time Ring", function ()
    local hp = Self.HealthPercent()
    local ring = Self.Ring()
    if hp <= HPPERC then
        if ring.id ~= ENERGY_RING.on then
            Self.EquipItem(SLOT_RING, ENERGY_RING.off, 1)
        end
    else
        if ring.id ~= TIME_RING.on then
            Self.EquipItem(SLOT_RING, TIME_RING.off, 1)
        end
    end
end)
