--[[
    Script Name: 		Soft Boots Changer
    Description: 		Load a new softs boots from backpacks if other worn.
    Author: 			Ascer - example
]]

local SOFT_BOOTS_NEW_ID = 3549          -- id of new soft boots 
local SOFT_BOOTS_USING = 3246           -- id of already using soft boots on feet.

-- DON'T EDIT BELOW THIS LINE

Module.New("Soft Boots Changer", function (mod)
    
	-- load feet.
	local feet = Self.Feet().id

	-- when no boots on feet.
    if feet <= 0 then

    	-- equip brand new softs.
    	Self.EquipItem(SLOT_FEET, SOFT_BOOTS_NEW_ID, 1)

    else	

    	-- when on feet are different boots than already using softs.
    	if feet ~= SOFT_BOOTS_USING then

    		-- dequip boots to any opened container.
    		Self.DequipItem(SLOT_FEET)

    	end	
        
    end

    mod:Delay(500, 1200) -- set a delay
    
end)

