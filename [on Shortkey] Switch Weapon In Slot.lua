--[[
    Script Name:        [on Shortkey] Switch Weapon In Slot
    Description:        Switch weapon in slot, its shortkey usage script type: EXECUTE name
    Author:             Ascer - example
]]


local config = {
    first = 3300,		-- first weapon id
    second = 3265		-- second weapon id
}

local weapon = Self.Weapon()

if weapon.id == 0 or weapon.id == config.second then
    Self.EquipItem(SLOT_WEAPON, config.first, 1, 0)
elseif weapon.id == config.first then
    Self.EquipItem(SLOT_WEAPON, config.second, 1, 0)
end 