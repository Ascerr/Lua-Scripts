--[[
    Script Name: 		Switch Soft Boots with other
    Description: 		Load soft boots when low mana and later switch to other boots.
    Author: 			Ascer - example
]]

local SOFT_BOOTS = {using = 3549, notUsing = 6529}  -- if of soft boots using (in equipment feet slot) and not using (in backpack)
local OTHER_BOOTS = 1324                            -- switch to this boots when mana above MANA_PERCENT
local MANA_PERCENT = 80                             -- check this mana percent to wear softs or not.


-- DON'T EDIT BELOW THIS LINE

Module.New("Switch Soft Boots with other", function (mod)
    
	-- load feet and mana.
	local feet = Self.Feet().id
    local mana = Self.ManaPercent()

    -- when low mana
    if Self.ManaPercent() < MANA_PERCENT then

    	-- when no softs on
        if feet.id ~= SOFT_BOOTS.using then

        	-- equip softs.
        	Self.EquipItem(SLOT_FEET, SOFT_BOOTS.notUsing, 1)

        end

    else 	

        -- when no other boots.
        if feet.id ~= OTHER_BOOTS then

            -- equip other boots.
            Self.EquipItem(SLOT_FEET, OTHER_BOOTS, 1)

        end   	
            
    end

    mod:Delay(500, 1200) -- set a delay
    
end)
