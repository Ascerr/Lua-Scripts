--[[
    Script Name:        On Low HP Drop Bp
    Description:        Drop Backpack slot on x, y, z when your character have low hp.
    Author:             Ascer - example
]]


local HPPERC = 50                               -- drop bp if hpperc below
local GROUND_POSITION = {32317, 32235, 7}       -- drop to this ground pos


-- DON'T EDIT BELOW THIS LINE

Module.New(" On Low HP Drop Bp", function ()

    -- if we are connected.
    if Self.isConnected() then

        -- load self health
        local hp = Self.HealthPercent()

        -- when hp below config value.
        if hp <= HPPERC then

            -- load backpack slot
            local backpack = Self.Backpack()

            -- when bp id > 0
            if backpack.id > 0 then

                -- drop on ground.
                Container.MoveItemFromEquipmentToGround(SLOT_BACKPACK, GROUND_POSITION[1], GROUND_POSITION[2], GROUND_POSITION[3], backpack.id, 1)

            end 

        end    

    end
        
end)
