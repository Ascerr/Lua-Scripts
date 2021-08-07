--[[
    Script Name: 		Auto Exori Con
    Description: 		Cast exori con if target > 0 and hpperc > 50% and depent on monsters on screen
    Author: 			Ascer - example
]]


local config = {
    spell = {name = "exori con", mana = 25},                -- spell name and mana to cast
    monsters = {"Dragon", "Dragon Lord", "Rat", "Cyclops"}, -- monsters list we cast spell
    amount = 1,                                             -- minimal monsters amount on screen to cast spell
    selfHpperc = 50,                                        -- dont cast if self hpperc below this value.
}


-- DON'T EDIT BELOW
config.monsters = table.lower(config.monsters)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getMonsters()
--> Description:    Read monsters for param1 (count) and param2 (current attacked)
--> Params:         None
-->                
--> Return:         integer - count, table (if true) - creature, 0 (if false)
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters()
    local count, target, current = 0, Self.TargetID(), 0
    for i, mob in ipairs(Creature.iMonsters(7, false)) do
        if table.find(config.monsters, string.lower(mob.name)) then
            count = count + 1
            if target == mob.id then
                current = mob
            end    
        end    
    end
    return count, current    
end 


-- module
Module.New("Auto Exori Con", function (mod)
    
    -- when hp is ok and we have target
    if Self.HealthPercent() > config.selfHpperc and Self.Mana() >= config.spell.mana then

        -- load count and target
        local count, target = getMonsters()

        -- when count is ok and is target.
        if count >= config.amount and table.count(target) > 0 then
    	
        	-- cast spell
        	Self.CastSpell(config.spell.name)

        end    

    end

    -- execute delay
    mod:Delay(300, 500)

end)
