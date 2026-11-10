--[[
    Script Name:        Enable cavebot when no monster
    Description:        Force eat food inside corpse of monsters
    Author:             Ascer - example
]]

local MONSTERS = {"Training Hero"}    -- Name of monsters to detect
local AFTER_TIME = 5                  -- if no monster on screen for _ s.    

-- DON'T EDIT BELOW THIS LINE
MONSTERS = table.lower(MONSTERS)
st = 0

function hero()
    for _, c in ipairs(Creature.iMonsters(7, false)) do
        if table.find(MONSTERS, string.lower(c.name)) then 
            return true
        end    
    end
    return false    
end    


Module.New("Enable cavebot when no monster", function ()
    if Self.isConnected() then
        if not hero() then
            if st == 0 then
                st = os.clock()
            else
                if os.clock() - st >= AFTER_TIME then
                    if not Cavebot.isEnabled() then
                        Cavebot.Enabled(true)
                        st = 0
                    end    
                end    
            end    
        else
            st = 0
        end    
    end    
end)
