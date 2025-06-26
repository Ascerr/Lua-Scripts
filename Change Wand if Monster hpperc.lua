--[[
    Script Name: 		Change Wand if Monster hpperc
    Description: 		Wear standard wand if monster hpperc is high and switch to wand which costs less mane ig monster hpperc is low.
    Author: 			Ascer - example
]]


local config = {
    strongWand = 3031,          -- id of strong wand costs more mana
    weakWand = 3492,            -- id of weak wand cost less mana
    hpperc = 10,                -- hpperc of monster to wear weakWand
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Change Wand if Monster hpperc", function ()
    if Self.isConnected() then
        local target = Self.TargetID()
        local targetMonster = Creature.getCreatures(target)
        if table.count(targetMonster) > 1 then
            local wand = Self.Weapon().id
            if targetMonster.hpperc <= config.hpperc then
                if wand ~= config.weakWand then
                    Self.EquipItem(SLOT_WEAPON, config.weakWand, 1, 200)
                end    
            else
                if wand ~= config.strongWand then
                    Self.EquipItem(SLOT_WEAPON, config.strongWand, 1, 200)
                end
            end    
        end 
    end    
end)
