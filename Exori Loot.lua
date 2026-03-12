--[[
    Script Name:        Exori Loot
    Description:        When looting say spell: exori loot, then quick pause looter.
    Author:             Ascer - example
]]

local SPELL = "exori loot"      --> spell to say.
local DELAY = 2000              --> delay to use spell in miliseconds

-- DON'T EDIT BELOW THIS LINE

Module.New("Exori Loot", function ()
    if Self.isConnected() then
        if Looter.isLooting() then
            Self.CastSpell(SPELL, 20, DELAY)
        end    
    end 
end)