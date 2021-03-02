--[[
    Script Name:        
    Description:        Boost Knight with incuro mas par when monsters on screen
    Author:             Ascer - example
]]

local BOOT_PLAYER = "Nick Here" -- player to boots
local DELAY = 10                -- cast spell every 10s

-- DON'T EDIT BELOW THIS LINE

function getCreature()

    local player, monster = false, false

    -- inside loop for monsters
    for i, c in pairs(Creature.iCreatures(7, false)) do
        
        -- when we found player
        if string.lower(c.name) == string.lower(BOOT_PLAYER) then player = true end

        -- set monster
        if Creature.isMonster(c) then monster = true end

        -- all found
        if player and monster then return true end

    end  

    -- don't found
    return false

end

Module.New("Medivia Boot Knight", function (mod)
    
    -- when found creature cast boot player
    if getCreature() then
        Self.CastSpell("incuro mas par \"" .. BOOT_PLAYER, 65, (DELAY * 1000))
    end 
        
    -- set some delay
    mod:Delay(500, 700)    
end)