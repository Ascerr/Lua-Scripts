--[[
    Script Name: 		Equip E ring if Monster Name
    Description: 		When specific monsters on screen equip ering. 
    Author: 			Ascer - example
]]
    
local config = {
    ring = {off = 3051, on = 3088},                             -- rings id when {off} in bp, {on} in equipment
    otherRing = {enabled = false, off = 2344, on = 3344},        -- {optional} put other ring instead of dequiping e ring. If ring don't change their ids then put this same is in {on} and {off}
    monsters = {
        amount = 2,                                             -- how many monsters detected on screen
        names = {"Dragon Lord", "Demon", "Demon Skeleton"},     -- monsters names.
    }
}


-- DON'T EDIT BELOW THIS LINE

-- lower table
config.monsters.names = table.lower(config.monsters.names)

Module.New("Equip E ring if Monster Name", function ()
    
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
