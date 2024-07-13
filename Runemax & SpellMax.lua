--[[
    Script Name: 		Runemax & SpellMax
    Description: 		Shoot rune or cast spell into target.
    Author: 			Ascer - example
]]

local CONFIG = {
    rune = {enabled = true, id = 3174, range = 7, hpperc = {min = 0, max = 100}},              -- shoot rune with target, [id] of rune (3155 is SD), [range] - sqms to target, [enabled] - true/false
    spell = {enabled = true, name = "exori con", range = 7, hpperc = {min = 0, max = 100}},   -- cast spell with target, [name] of spell (exori con), [range] - cast if monster in distance to you , [hpperc] - cast shoot only when monster hpperc will between walue [min] and [max]
    health = 60,                                                -- dont shoot/cast if self character hpperc below this value
    amount = 1,                                                 -- min monsters amount
    monsters = {"Rat", "Rotworm"}                                 -- monsters names to cast spell or shoot rune.    
}

-- DON'T EDIT BELOW THIS LINE

-- converting table to lowercase
CONFIG.monsters = table.lower(CONFIG.monsters)

function getMonsters()
    local count = 0
    for _, c in ipairs(Creature.iMonsters(7, false)) do
        if table.find(CONFIG.monsters, string.lower(c.name)) then
            count = count + 1
        end    
    end
    return count    
end --> return amount of monsters on screen.

Module.New("Runemax & SpellMax", function()

    -- load self hpperc
    local hp = Self.HealthPercent()

    -- when hp is above value
    if hp > CONFIG.health then

        -- load target id.
        local target = Self.TargetID()

        -- check for target id.
        if target > 0 then

            -- load creature 
            local c = Creature.getCreatures(target)

            -- when is table.
            if table.count(c) > 0 and getMonsters() > CONFIG.amount then

                -- when creature is alive and is valid monster name.
                if c.hpperc > 0 and table.find(CONFIG.monsters, string.lower(c.name)) then

                    -- check for rune config.
                    if CONFIG.rune.enabled and Creature.DistanceFromSelf(c) <= CONFIG.rune.range and (c.hpperc >= CONFIG.rune.hpperc.min and c.hpperc <= CONFIG.rune.hpperc.max) then

                        -- shoot rune.
                        Self.UseItemWithCreature(c, CONFIG.rune.id, math.random(2000, 2300))
   
                    -- check for spell config    
                    elseif CONFIG.spell.enabled and Creature.DistanceFromSelf(c) <= CONFIG.spell.range and (c.hpperc >= CONFIG.spell.hpperc.min and c.hpperc <= CONFIG.spell.hpperc.max) then

                         -- cast spell.
                        Self.CastSpell(CONFIG.spell.name, 20, math.random(700, 1500))

                    end    

                end   

            end    

        end

    end        

end)
