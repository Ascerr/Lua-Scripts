--[[
    Script Name: 		Pause walker for while to refill mana
    Description: 		When you hunting difficult monsters this script will pause walker when your mpperc is low to refill mana and start again.
    Required:           This script is not responsible for refill mana it only switch on/off walker. Use build-in option to refill mana.
    Author: 			Ascer - example
]]

local MANA_PERCENT = {min = 50, max = 90}  -- Pause walker when mana percent below min - 50%, refill up to max - 90% then enable walker.
local IF_NO_CREATURES = false              -- pause only if no creatures on screen

-- DON'T EDIT BELOW THIS LINE

function getMobs()
    for i, mob in pairs(Creature.iMonsters(7, false)) do
        return true
    end
    return false    
end 

-- 
Module.New("Pause walker for while to refill mana", function()
    if Self.isConnected() then
        local mpperc = Self.ManaPercent()
        if mpperc <= MANA_PERCENT.min and ((IF_NO_CREATURES and not getMobs()) or not IF_NO_CREATURES) then
            if Walker.isEnabled() then Walker.Enabled(false) end
        else
            if mpperc >= MANA_PERCENT.min then
                if not Walker.isEnabled() then Walker.Enabled(true) end
            end    
        end    
    end    
end)
