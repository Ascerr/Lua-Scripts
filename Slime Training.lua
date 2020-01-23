--[[
    Script Name: 		Slime Training
    Description: 		Fist recognize mother attack it and run script. Rifbot mark mother and will avoid it.
    Author: 			Ascer - example
]]

local MAIN_DELAY = {500, 1800}		-- set your delay
local MONSTER = "Slime" 		-- monster name
local RANGE = 1				-- attack when moster distance from self = 1, set more if u're paladin
local OFFSET_CREATURE_ADDON = 72	-- addon mob offset in memory (Realesta 68) Retrocores (72)

-- DONT'T EDIT BELOW THIS LINE

local mother = 0

Module.New("Slime Training", function (mod)

	-- find and mark mother
	if mother <= 0 then
		local target = Self.TargetID()
		for i, mob in pairs(Creature.iMonsters(7)) do
			if mob.name == MONSTER then
				if target == mob.id then
					mother = mob.id
					Rifbot.MemoryWrite(mob.addr + OFFSET_CREATURE_ADDON , 35, "dword") -- change mother slime to Demon XD working until you change floor or logout
					Self.Stop() -- stop attack mother.
					break
				end
			end
		end
	else
		-- control monsters.
		local target = Self.TargetID()
		if target == mother then
			Self.Stop() -- stop attack if mother is target.
		end
		
		if target == 0 then -- do actions only if target.id = 0
			for i, mob in pairs(Creature.iMonsters(RANGE)) do
				if mob.name == MONSTER and mob.id ~= mother then
					Creature.Attack(mob.id) -- attack slime summon
					break
				end	
			end
		end
	end				

	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)
