--[[
    Script Name:        Drink mana fluid if no monsters
    Description:        Drink mana fluid when no monsters on screen.
    Author:             Ascer - example
]]

local UP_TO_MPPERC = 50     -- drink mana fluids upto 50%


-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getMonsters()
--> Description:    Read creatures for monsters on screen.
--> Class:          None
--> Params:         None
--> Return:         boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters()
    for i, mob in pairs(Creature.iMonsters(7, false)) do
        return true
    end
    return false
end

-- loop module.
Module.New("Drink mana fluid if no monsters", function ()
    
    -- when health below
    if Self.ManaPercent() < UP_TO_MPPERC then

        -- when no monsters.
        if not getMonsters() then

            -- drink mf MANA_FLUID.id is default if of mana fluid.
           Self.UseItemWithMe(MANA_FLUID.id, 1000)

        end 

    end

end)