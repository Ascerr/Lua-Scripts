--[[
    Script Name:        [on label] Mechanical Rod actions
    Description:        When you fishing using mechanical rod this script will:
                        1. Check if rod is broken
                        2. Purchase rod at shop
                        3. Throw out not valuable items.

                        Example waypoints at the end of script.
    Author:             Ascer - example
]]

local config = {
    label_shop = "shop",                            -- do this action on this current label in walker (purchasing charges for rod).
    label_check = "check",                          -- check for rod if it's broken or not.
    label_back = "back",                            -- go to this label if rod is broken.
    skip_if_npc_taken = true,                       -- when npc is taken skip.
    mechanical_rod = {new = 5331, broken = 5455},   -- ids for new and broken mechanical rod.
    drop = {                        
        enabled = true,                             -- true/false enable throw out to water items 
        pos = {x = 229, y = 97, z = 7},             -- position where throw items.
        items = {3578, 5328, 5329}                  -- items to throw.
    }   
}

-- DON'T EDIT BELOW

function creatureOnPos(x, y, z)
    local me = Self.Name()
    for _, c in ipairs(Creature.iCreatures(7, false)) do
        if c.x == x and c.y == y and c.z == z and c.name ~= me.name then return true end   
    end
    return false    
end --> return true or false if creature is on pos.   

function signal(label)
    if label == config.label_shop then
        local npc = Creature.getCreatures("George Specialist")
        if table.count(npc) > 1 then
            if (not config.skip_if_npc_taken or npc.direction == 1 or (npc.direction == 3 and not creatureOnPos(222, 106, 6))) then
                Self.Say("hi")
                wait(500)
                Self.Say("mechanical rod")
                wait(200)
                Self.Say("yes")
            end  
        end
    elseif label == config.label_check then
        if Self.ItemCount(config.mechanical_rod.broken) > 0 then
            Walker.Goto(config.label_back)
        end         
    end
end

-- call function
Walker.onLabel("signal")

-- module to throw items.
Module.New("Drop items to water", function()
    if Self.isConnected() then
        if config.drop.enabled then
            local item = Container.FindItem(config.drop.items)
            if table.count(item) > 1 then
                Self.DropItem(config.drop.pos.x, config.drop.pos.y, config.drop.pos.z, item.id, item.count)
            end    
        end    
    end
end)

--[[ EXAMPLE WAYPOINTS HERE:

fishing
node: 231, 97, 7
check
goto: fishing
back
node: 235, 100, 7
node: 234, 107, 7
node: 230, 108, 7
stand: 228, 108, 7
node: 225, 107, 6
node: 225, 106, 6
stand: 226, 106, 6
shop
node: 226, 108, 6
stand: 228, 108, 6
node: 231, 107, 7
node: 236, 105, 7
node: 234, 100, 7

]]
