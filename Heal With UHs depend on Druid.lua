--[[
    Script Name:        Heal With UHs depend on Druid
    Description:        Heal yourself with UHs if no druid with sio then percentage higher, if druid on screen then lower.
    Author:             Ascer - example
]]

local UH_ID = 3160                      -- ID of uh rune
local HEALING = {yes = 50, no = 70}     -- yes - is druid on screen % hp, no - there is no druid on screen percentage.
local DRUID = "Benjamin"                -- nick of druid.

-- DON'T EDIT BELOW THIS LINE

function isDruid()
    for _, c in ipairs(Creature.iPlayers(10, false)) do-- 10 is range sqms for reading players it depends on ot.
        if string.lower(c.name) == string.lower(DRUID) and Creature.isOnScreen(c) then
            return true
        end    
    end
    return false    
end    --> retrun true or false depend if druid is on screen or not

Module.New("Heal With UHs depend on Druid", function()
    if Self.isConnected() then 
        local value = HEALING.no
        if isDruid() then
            value = HEALING.yes
        end 
        if Self.HealthPercent() <= value then
            Self.UseItemWithMe(UH_ID, 1000) -- use item every 1s.
        end    
    end    
end)