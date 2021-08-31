--[[
    Script Name: 		Shoot Poison Field with Warlock
    Description: 		Shoot poison filed rune with warlock once he appear.
    Author: 			Ascer - example
]]

local config = {
    monsters = {"Warlock", "rotworm"},     -- add here monster names
    runeid = 3172               -- rune to shoot
}


-- DONT'T EDIT BELOW THIS LINE

config.monsters = table.lower(config.monsters)
local storage, shootTime = {}, 0

Module.New("Shoot Poison Field with Warlock", function ()
    for i, mob in pairs(Creature.iMonsters(7, false)) do
        if table.find(config.monsters, string.lower(mob.name)) then
            if not table.find(storage, mob.id) then
                if os.clock() - shootTime > 2 then
                    Self.UseItemWithCreature(mob, config.runeid, 0)
                    table.insert(storage, mob.id)
                    shootTime = os.clock()
                    break
                end
            end        
        end
    end            
end)