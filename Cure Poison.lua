--[[
    Script Name:        Cure Poison
    Description:        Cast exana pox when your character under poison cond.
    Author:             Ascer - example
]]

Module.New("Cure Poison", function ()
    if Self.isPoisioned() then
        Self.CastSpell("exana pox", 30)
    end    
end)