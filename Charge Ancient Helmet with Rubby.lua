--[[
    Script Name:        Charge Ancient Helmet with Rubby.
    Description:        Recharge helmet when is no longer adding you energy. Rubbies need to be inside backpack slot.
    Require:            Rifbot version 1.63 or higher.
    Author:             Ascer - example
]]

local HELMET = 3229     -- id of helmet of ancients (used) no longer regenerate hp/mana, 
local RUBBY = 3030      -- id of rubby to charge helmet


-- DONT'T EDIT BELOW THIS LINE

Module.New("Charge Ancient Helmet with Rubby", function (mod)

    -- when helmet is used.
    if Self.Head().id == HELMET then

        -- find rubby item.
        local item = Container.FindItem(RUBBY, nil)

        -- when item has found.
        if item ~= false then
            
            -- use rubby on helmet.
            Container.UseItemWithEquipment(item.index, item.slot, item.id, SLOT_HEAD, HELMET)

        end    
        
    end
    
    -- execution delay
    mod:Delay(1000, 1500)

end) 
