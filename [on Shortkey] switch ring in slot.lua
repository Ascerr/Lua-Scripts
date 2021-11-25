--[[
    Script Name:        [on Shortkey] switch ring in slot
    Description:        Switch ring depent on current in slot, its shortkey usage script type: EXECUTE name
    Author:             Ascer - example
]]


local config = {
    first = {on = 2344, off = 2342},    -- first ring to switch, on - id when ring inside eq, off - id when ring inside bp.
    second = {on = 2314, off = 2322}    -- second ring to switch, on - id when ring inside eq, off - id when ring inside bp.
}

local ring = Self.Ring()

if ring.id == 0 then
    Self.EquipItem(SLOT_AMMO, config.first.off, 1, 200)
elseif ring.id == config.first.on then
    Self.EquipItem(SLOT_AMMO, config.second.off, 1, 200)
else
    Self.EquipItem(SLOT_AMMO, config.first.off, 1, 200)
end 