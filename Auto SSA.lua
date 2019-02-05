--[[ 
    Script Name: 		Auto SSA
    Description: 		Automatically equip Stone Skin Amulet when slot.amulet is empty.
    Author: 			Ascer - example
]]

local SSA = 3081	-- id of stone skin amulet

Module.New("Auto SSA", function (mod) -- declare module name and set function mod
    if Self.Amulet().id == 0 then -- get currnet amulet.id
        Self.EquipItem(SLOT_AMULET, SSA, 1) -- equip stone skin amulet to amulet slot with quantity 1.
    end	
    mod:Delay(700, 1200)	-- set module execution delay random 500, 1200 ms
end)
