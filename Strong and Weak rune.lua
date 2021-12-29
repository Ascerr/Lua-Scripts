--[[
    Script Name: 		Strong and Weak rune
    Description: 		Shoot rune or cast spell into target.
    Author: 			Ascer (modified: Markus Etschmayer)
]]

local CONFIG = {
    rune = {enabled = true, id = 3155, range = 7, hpperc = {min = 20, max = 100}},              -- shoot rune with target e.g. SD, [id] of rune (3155 is SD), [range] - sqms to target, [enabled] - true/false, [hpperc] - shoot only when monster hpperc will between walue [min] and [max]
    lowRune = {enabled = true, id = 3198, range = 7, hpperc = {min = 0, max = 20}},   -- shoot rune with target e.g. HMM, [range] - shoot if monster in distance to you , [hpperc] - shoot only when monster hpperc will between walue [min] and [max]
    health = 60,                                                -- dont shoot/cast if self character hpperc below this value
    monsters = {"Frost Dragon"}                                 -- monsters names to cast spell or shoot rune.    
}

-- DON'T EDIT BELOW THIS LINE

-- converting table to lowercase
CONFIG.monsters = table.lower(CONFIG.monsters)

Module.New("Strong and Weak rune", function()

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
                    if CONFIG.rune.enabled and Creature.DistanceFromSelf(c) <= CONFIG.rune.range and (c.hpperc >= CONFIG.rune.hpperc.min and c.hpperc <= CONFIG.rune.hpperc.max) then

                        -- shoot rune.
                        Self.UseItemWithCreature(c, CONFIG.rune.id, math.random(2000, 2300))
   
                    -- check for rune lowconfig    
                    elseif CONFIG.lowRune.enabled and Creature.DistanceFromSelf(c) <= CONFIG.lowRune.range and (c.hpperc >= CONFIG.lowRune.hpperc.min and c.hpperc <= CONFIG.lowRune.hpperc.max) then

                        -- shoot rune.
						Self.UseItemWithCreature(c, CONFIG.lowRune.id, math.random(2000, 2300))

                    end    

                end   

            end    

        end

    end        

end)