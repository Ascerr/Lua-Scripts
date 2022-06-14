--[[
    Script Name:        Charge Weapon with Crystal
    Description:        Use crystals on weapon slot every 120min
    Author:             Ascer - example
]]

local TIME = 120                      -- time in minutes to restore charge
local CRYSTALS = {8593, 8540}         -- group of crystals to use {use once, use second, ..} if you want charge x2 with this same id use: {id, id}  

-- DONT'T EDIT BELOW THIS LINE

local startTime = -99999999

Module.New("Charge Weapon with Crystal", function ()

    -- when connected to game
    if Self.isConnected() then

        -- when time diff is valid.
        if os.clock() - startTime > (TIME * 60) then

            -- inside loop for crystal
            for i = 1, #CRYSTALS do

                -- find crystal item.
                local item = Container.FindItem(CRYSTALS[i], nil)

                -- when item has found.
                if item ~= false then
                    
                    -- load weapon id
                    local weapon = Self.Weapon()

                    -- use crystal on weapon slot.
                    Container.UseItemWithEquipment(item.index, item.slot, item.id, SLOT_WEAPON, weapon.id, 0)

                    -- wait some time
                    wait(1000, 1500)

                    -- update time
                    startTime = os.clock()

                end    

            end    

        end
        
    end
    
end) 