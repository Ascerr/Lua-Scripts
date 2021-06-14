--[[
    Script Name: 		Runemax & SpellMax
    Description: 		Shoot rune or cast spell into target.
    Author: 			Ascer - example
]]

local CONFIG = {
    rune = {id = 3155, range = 7, enabled = true},              -- shoot rune with target, [id] of rune (3155 is SD), [range] - sqms to target, [enabled] - true/false
    spell = {name = "exori con", range = 7, enabled = false},   -- cast spell with target, [name] of spell (exori con), ..
    health = 60,                                                -- dont shoot/cast if self character hpperc below this value
    monsters = {"Rat", "Snake"}                                 -- monsters names to cast spell or shoot rune.    
}

-- DON'T EDIT BELOW THIS LINE

-- converting table to lowercase
CONFIG.monsters = table.lower(CONFIG.monsters)

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
            if table.count(c) > 0 then

                -- when creature is alive and is valid monster name.
                if c.hpperc > 0 and table.find(CONFIG.monsters, string.lower(c.name)) then

                    -- check for rune config.
                    if CONFIG.rune.enabled then

                        -- when range is ok.
                        if Creature.DistanceFromSelf(c) <= CONFIG.rune.range then

                            -- shoot rune.
                            Self.UseItemWithCreature(c, CONFIG.rune.id, math.random(2000, 2300))

                        end    

                    -- check for spell config    
                    elseif CONFIG.spell.enabled then

                         -- when range is ok.
                        if Creature.DistanceFromSelf(c) <= CONFIG.spell.range then

                            -- cast spell.
                            Self.CastSpell(CONFIG.spell.name, 20, math.random(700, 1500))

                        end    

                    end    

                end   

            end    

        end

    end        

end)
