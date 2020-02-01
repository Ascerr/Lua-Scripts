--[[
    Script Name:        Heal monster
    Description:        Heal monster using UH rune. Important! Script don't recognize it's you summon or not.
    Author:             Ascer - example
]]

local MONSTER = "Demon Skeleton" -- monster name with Capital letters
local HEAL_BELOW_PERC = 50       -- heal if creature perc is below.
local RUNE_ID = 3160             -- rune id to use

-- DONT EDIT BELOW THIS LINE

Module.New("Heal monster", function ()

    -- load creatures 
    local creatures = Creature.iMonsters(7, false)

    -- in loop for creatures.
    for i = 1, #creatures do
        
        -- load single creature.
        local c = creatures[i]
        
        -- check if creature have below HEAL_BELOW_PERC and monster name is this same as config.
        if c.hpperc <= HEAL_BELOW_PERC and c.name == MONSTER then

            -- use rune with creature. 2050 is delay in ms.
            Self.UseItemWithCreature(c, RUNE_ID, 2050)

            -- break loop
            break

        end
        
    end        

end)
