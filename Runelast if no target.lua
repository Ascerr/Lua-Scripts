--[[
    Script Name:        Runelast if no target
    Description:        Shoot rune with last attacked monster if current targetID = 0.
    Author:             Ascer - example
]]

local RUNEID = 3174                         -- id of rune to shoot with last attacked ID
local MAX_DIST_FROM_LAST_TARGET_POS = 10    -- maximal accepted amount of sqms on this same floor to shoot rune from last known target position 
local MAX_SHOOTING_ATTEMPTS = 8             -- max possible tries to shoot rune before ignore target.
local DELAY = 2000                          -- shot every this milisecond

-- DON'T EDIT BELOW THIS LINE

local lastCreature, tries, timeVal = {id = 0}, 0, 0

Module.New("Runelast if no target", function()
    if Self.isConnected() then
        local t = Self.TargetID()
        if t > 0 then
            if lastCreature.id ~= t then
                local c = Creature.getCreatures(t)
                if table.count(c) > 2 and Creature.isMonster(c) then
                    lastCreature = c
                    tries = 0
                end
            end
        else
            if lastCreature.id > 0 and os.clock() - timeVal > DELAY/1000 then
                if Creature.DistanceFromSelf(lastCreature) <= MAX_DIST_FROM_LAST_TARGET_POS then
                    Self.UseItemWithCreature(lastCreature, RUNEID)
                end
                tries = tries + 1
                timeVal = os.clock() 
                if tries >= MAX_SHOOTING_ATTEMPTS then
                    lastCreature = {id = 0}
                end     
            end            
        end    
    end    
end)