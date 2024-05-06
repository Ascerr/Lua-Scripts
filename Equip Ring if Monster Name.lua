--[[
    Script Name: 		Equip Ring if Monster Name
    Description: 		When specific monsters on screen equip ring else dequip or switch to other ring. 
    Author: 			Ascer - example
]]
    
local config = {
    ring = {off = 3049, on = 3086},                             -- rings id when {off} in bp, {on} in equipment // for e ring use ids: off = 3051, on = 3088
    otherRing = {enabled = false, off = 2344, on = 3344},        -- {optional} put other ring instead of dequiping e ring. If ring don't change their ids then put this same is in {on} and {off}
    monsters = {
        amount = 2,                                             -- how many monsters detected on screen
        names = {"Dragon Lord", "Cyclops", "Demon Skeleton"},     -- monsters names.
    }
}


-- DON'T EDIT BELOW THIS LINE

-- lower table
config.monsters.names = table.lower(config.monsters.names)

Module.New("Equip Ring if Monster Name", function ()
    
    -- set count
    local count = 0

    -- in loop check for monsters
    for i, mob in pairs(Creature.iMonsters(7)) do
        if table.find(config.monsters.names, string.lower(mob.name)) then
            count = count + 1
            if count >= config.monsters.amount then
                if Self.Ring().id ~= config.ring.on then
                    Self.EquipItem(SLOT_RING, config.ring.off, 1)
                end    
            end    
        end
    end
    
    -- check for dequip
    if count < config.monsters.amount then
        if config.otherRing.enabled then
            if Self.Ring().id ~= config.otherRing.on then
               Self.EquipItem(SLOT_RING, config.otherRing.off, 1) 
            end    
        else    
            if Self.Ring().id == config.ring.on then
                Self.DequipItem(SLOT_RING)
            end
        end        
    end  
    
end)
