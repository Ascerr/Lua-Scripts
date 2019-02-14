--[[
    Script Name: 		Soft Boots Changer
    Description: 		Load a new softs boots from backpacks if other worn.
    Author: 			Ascer - example
]]

local SOFT_BOOTS_NEW_ID = 3549          -- id of new soft boots 
local SOFT_BOOTS_USING = 3246           -- id of already using soft boots on feet.

-- DON'T EDIT BELOW THIS LINE

Module.New("Soft Boots Changer", function (mod)
    if Self.Feet().id ~= SOFT_BOOTS_USING then
        Self.EquipItem(SLOT_FEET, SOFT_BOOTS_NEW_ID, 1)
    end    
    mod:Delay(500, 1200) -- set a delay
end)

