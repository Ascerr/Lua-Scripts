--[[ 
    Script Name: 		Fast Auto SSA & Might Ring
    Description: 		Spam equipming Stone Skin Amulet (delay 200ms).
    Author: 			Ascer - example
]]

local SSA = 3081	-- id of stone skin amulet
local MRING = 3048	-- id of might ring

Module.New("Fast SSA & Might Ring", function (mod) -- declare module name and set function mod
    Self.EquipItem(SLOT_AMULET, SSA, 1, 1) -- equip stone skin amulet to amulet slot with quantity 1.
    wait(100)
    Self.EquipItem(SLOT_RING, MRING, 1, 1) -- equip might ring
end)
