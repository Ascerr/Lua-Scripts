--[[
    Script Name:        Heal with Life Fluid
    Description:        Heal your character with life fluid (must be visible in containers)
    Author:             Ascer - example
]]

local config = {
    hpperc = 80,                            -- when self health percent below this value eat food.
    fluid = {id = 2874, qt = 5},           -- fluid id and fluid quantity (its important and different for servers could be also: 2 or 5 or 10)
    delay = 1000                            -- drinking delay
}

-- DON'T EDIT BELOW
local useTime = 0

function getLifeFluid()
    local items = Container.getItems()
    for i, cont in pairs(items) do 
        local contItems = cont.items
        for j, item in pairs(contItems) do
            --print(item.id, item.count)
            if item.id == config.fluid.id and item.count == config.fluid.qt then
                return {index = cont.index, slot = (j - 1), id = item.id, count = item.count}
            end     
        end
    end
end --> return item struct or nothing   

-- mod 200ms
Module.New("Heal with Life Fluid", function()
    if Self.isConnected() then
        if Self.HealthPercent() <= config.hpperc then
            if os.clock() - useTime >= config.delay/1000 then
                local lf = getLifeFluid()
                if table.count(lf) > 0 then
                    local me = Creature.getCreatures(Self.ID())
                    if table.count(me) > 1 then
                        Container.UseItemWithCreature(lf.index, lf.slot, lf.id, me, 0)
                        useTime = os.clock()
                    end    
                end
            end     
        end 
    end 
end)