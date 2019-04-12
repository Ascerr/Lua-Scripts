--[[ 
    Script Name: 		Fast Auto SSA
    Description: 		Automatically equip Stone Skin Amulet when slot.amulet is empty. (delay 200ms).
    Author: 			Ascer - example
]]

local SSA = 3081	-- id of stone skin amulet

Module.New("Auto SSA", function (mod) -- declare module name and set function mod
    if Self.Amulet().id == 0 then -- get currnet amulet.id
        Self.EquipItem(SLOT_AMULET, SSA, 1, 1) -- equip stone skin amulet to amulet slot with quantity 1.
    end        
end)
