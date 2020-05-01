--[[
    Script Name:        Charge Ancient Helmet with Rubby.
    Description:        Recharge helmet when is no longer adding you energy.
    Require:            Rifbot version 1.63 or higher.
    Author:             Ascer - example
]]

local HELMET = 3229    -- id of helmet of ancients (used) no longer regenerate hp/mana, 
local RUBBY = {id = 3030, slot = SLOT_AMMO} -- if of rubby to charge helmet, (slot) in equipment where rubbies are located.

-- DONT'T EDIT BELOW THIS LINE

Module.New("Charge Ancient Helmet with Rubby", function (mod)

    -- when helmet is used.
    if Self.Head().id == HELMET then

        -- check for rubby in eq.
        if selfGetEquipmentSlot(RUBBY.slot).id == RUBBY.id then

            -- use rubby on helmet.
            Container.UseItemWithEquipmentOnEquipment(SLOT_HEAD, HELMET, RUBBY.slot, RUBBY.id)

        end    

    end
   
    mod:Delay(1000, 1500)     
end) 
