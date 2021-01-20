--[[
    Script Name: 		Switch SSA
    Description: 		Equip SSA when mana is below 40% and dequip if above.
    Author: 			Ascer - example
]]

local AMULET_ID = 3081 		-- id amulet to wear (default ssa 3081)
local MPPERC = 75			-- when mana percent <= this percent then wear ssa else dequip.

Module.New("Switch SSA", function (mod)
    local mp = Self.ManaPercent()
    local amulet = Self.Amulet()
    if mp <= MPPERC then
        if amulet.id ~= AMULET_ID then
            Self.EquipItem(SLOT_AMULET, AMULET_ID, 1)
        end
    else
        if amulet.id == AMULET_ID then
            Self.DequipItem(SLOT_AMULET) -- dequip amulet
        end
    end
    -- mod:Delay(200) delay execute script default disabled
end)