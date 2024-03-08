--[[
    Script Name:        Select target for area arrow
    Description:        Select best target to hit max amount of monsters with area arrow.
    Author:             Ascer - example
]]

local config = {
    searchForRange = 7,             -- default full screen.
    arrowAttackRange = 1            -- attacking arrow sqms distance near target. For brust arrow = 1
}


function creatureDistanceFromCreature(c, c2)
    if type(c) ~= "table" then
        return 10
    end
    if type(c2) ~= "table" then
        return 10
    end
    local absx = math.abs(c.x - c2.x)
    local absy = math.abs(c.y - c2.y)
    local ret = absx
    if absy > absx then
        ret = absy
    end
    return ret  
end --> calculate distance between creatures c and c2


function selectTarget(monsters)
    local lastCount, lastMonster = 0, -1
    for _, c in ipairs(monsters) do
        local monstersNear = 0
        for _, c2 in ipairs(monsters) do
            if creatureDistanceFromCreature(c, c2) <= config.arrowAttackRange then
                monstersNear = monstersNear + 1
            end 
        end
        if monstersNear > lastCount then
            lastCount = monstersNear
            lastMonster = c
        end 
    end
    if table.count(lastMonster) < 3 then
        return -1
    end
    return lastMonster      
end --> choose target to shoot max amount with area arrow.  


Module.New("Select target for area arrow", function()
    if Self.isConnected() then
        local t = selectTarget(Creature.iMonsters(config.searchForRange, false))
        if table.count(t) > 3 then
            if Self.TargetID() ~= t.id then
                Creature.Attack(t.id)
            end
        end
    end         
end)
