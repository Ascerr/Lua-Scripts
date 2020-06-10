--[[
    Script Name: 		Runemax & SpellMax
    Description: 		Shoot rune or cast spell into target.
    Author: 			Ascer - example
]]

local CONFIG = {
    rune = {id = 3155, range = 7, enabled = true},              -- shoot rune with target, [id] of rune (3155 is SD), [range] - sqms to target, [enabled] - true/false
    spell = {name = "exori con", range = 7, enabled = false}    -- cast spell with target, [name] of spell (exori con), ..
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Runemax & SpellMax", function()

    -- load target id.
    local target = Self.TargetID()

    -- check for target id.
    if target > 0 then

        -- load creature 
        local c = Creature.getCreatures(target)

        -- when is table.
        if table.count(c) > 0 then

            -- when creature is alive.
            if c.hpperc > 0 then

                -- check for rune config.
                if CONFIG.rune.enabled then

                    -- when range is ok.
                    if Creature.DistanceFromSelf(c) <= CONFIG.rune.range then

                        -- shoot rune.
                        Self.UseItemWithCreature(c, CONFIG.rune.id, math.random(1900, 2200))

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

end)