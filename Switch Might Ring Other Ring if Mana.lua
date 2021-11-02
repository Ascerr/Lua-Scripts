--[[
    Script Name: 		Switch Might Ring Other Ring if Mana
    Description: 		Equipe might ring when mana below x else wear other ring
    Author: 			Ascer - example
]]

local MIGHT_RING = 3048     -- id of might ring
local OTHER_RING = 3010     -- id of ther ring 
local MPPERC = 40	          -- when mpperc below this value wear might ring else other ring.

Module.New("Switch Might Ring Other Ring if Mana", function ()
    local mp = Self.ManaPercent()
    local ring = Self.Ring()
    if mp <= MPPERC then
        if ring.id ~= MIGHT_RING then
            Self.EquipItem(SLOT_RING, MIGHT_RING, 1, math.random(200, 300))
        end
    else
        if ring.id ~= OTHER_RING then
            Self.EquipItem(SLOT_RING, OTHER_RING, 1, math.random(200, 300))
        end
    end
end)