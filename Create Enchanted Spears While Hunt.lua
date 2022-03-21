--[[
    Script Name:        Create Enchanted Spears While Hunt
    Description:        When you hunting with example Royal Spears and mana is high wear spear and create enchanted spear then restore royals.
    Author:             Ascer - example
]]

local config = {
    mpperc = 90,                -- when mana % is equal or above create enchanted spear. 
    spell = "exeta con",        -- spell to create enchanted spear.
    spear = 3277,               -- id of basic spear
    attack_weapon = 7037        -- id of royal spear or other.
}

-- DON'T EDIT BELOW

Module.New("Create Enchanted Spears While Hunt", function ()

    -- when connected
    if Self.isConnected() then

        -- load slot weapon
        local weapon = Self.Weapon()

        -- when mana is above
        if Self.ManaPercent() >= config.mpperc then

            -- when we have spear inside slot
            if weapon.id == config.spear then

                -- cast spell
                Self.CastSpell(config.spell)

            else
                
                -- wear basic spear 
                Self.EquipItem(SLOT_WEAPON, config.spear, 1, 300)

            end    

        else
            
            -- when weapon is diff than attack weapon
            if weapon.id ~= attack_weapon then

                -- wear attack weapon with max possible quantity (this allow to wear whole slot amount of container)
                Self.EquipItem(SLOT_WEAPON, config.attack_weapon, 100, 300)

            end    

        end   

    end

end) 