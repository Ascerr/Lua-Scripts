--[[
    Script Name:        [on Shortkey] switch arrow in slot
    Description:        Switch arrow depent on current in slot, its shortkey usage script type: EXECUTE name
    Author:             Ascer - example
]]


local config = {
    arrow = 3447,               -- id o basic arrow
    hunting_arrow = 1111,       -- id of hunting arrow or other
}

local ammo = Self.Ammo()

if ammo.id == 0 then
    Self.EquipItem(SLOT_AMMO, config.arrow, 1, 200)
elseif ammo.id == config.arrow then
    Self.EquipItem(SLOT_AMMO, config.hunting_arrow, 100, 200)
else
    Self.EquipItem(SLOT_AMMO, config.arrow, 100, 200)
end 
