
--[[
    Script Name: 		Switch Might Ring Other Ring if Mana
    Description: 		Equip might ring & SSA when mana below x else wear other ring
    Author: 			Ascer - example
]]

local AMULET_ID = 3081 		-- id amulet to wear (default ssa 3081)
local MIGHT_RING = 3048     -- id of might ring
local OTHER_RING = 3010     -- id of ther ring 
local MPPERC = 40	         -- when mpperc below this value wear might ring and ssa else wear other ring.

--> SSA
Module.New("Switch SSA", function (mod)
    local mp = Self.ManaPercent()
    local amulet = Self.Amulet()
    if mp <= MPPERC then
        if amulet.id ~= AMULET_ID then
            Self.EquipItem(SLOT_AMULET, AMULET_ID, 1, 0)
        end
    end
end)

--> Might ring
Module.New("Switch Might Ring Other Ring if Mana", function ()
    local mp = Self.ManaPercent()
    local ring = Self.Ring()
    if mp <= MPPERC then
        if ring.id ~= MIGHT_RING then
            Self.EquipItem(SLOT_RING, MIGHT_RING, 1, 0)
        end
    else
        if ring.id ~= OTHER_RING then
            Self.EquipItem(SLOT_RING, OTHER_RING, 1, 0)
        end
    end
end)


