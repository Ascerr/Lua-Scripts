--[[
    Script Name: 		Equip Amulet if Monster Name
    Description: 		When specific monsters on screen equip amulet else dequip or wear other one. 
    Author: 			Ascer - example
]]
    
local config = {
    amulet = 3572,                                              -- amulet id 
    otherAmulet = {enabled = false, id = 3085},                 -- {optional} put other amulet instead of dequiping.
    monsters = {
        amount = 2,                                             -- how many monsters detected on screen
        names = {"Dragon Lord", "Rat", "Demon Skeleton"},       -- monsters names.
    }
}


-- DON'T EDIT BELOW THIS LINE

-- lower table
config.monsters.names = table.lower(config.monsters.names)

Module.New("Equip Amulet if Monster Name", function ()
    
    -- set count
    local count = 0

    -- in loop check for monsters
    for i, mob in pairs(Creature.iMonsters(7)) do
        if table.find(config.monsters.names, string.lower(mob.name)) then
            count = count + 1
            if count >= config.monsters.amount then
                if Self.Amulet().id ~= config.amulet then
                    return Self.EquipItem(SLOT_AMULET, config.amulet, 1)
                end    
            end    
        end
    end
    
    -- check for dequip
    if count < config.monsters.amount then
        if config.otherAmulet.enabled then
            if Self.Amulet().id ~= config.otherAmulet.id then
               Self.EquipItem(SLOT_AMULET, config.otherAmulet.id, 1) 
            end    
        else    
            if Self.Amulet().id == config.amulet then
                Self.DequipItem(SLOT_AMULET)
            end
        end        
    end  
    
end)