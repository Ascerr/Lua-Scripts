--[[
    Script Name:        Prioritize Demonic or Ranged Mobs
    Description:        Switch target to monster special created.
    Author:             Ascer - example
]]

local config = {
	monsters = {"Demonic", "Ranged"}, 	-- special monsters added status
	range = 3 							-- area in sqms we search for this mobs, warring! longer range may lead to attack not reachable targets
}

-- DON'T EDIT BELOW
function isSpecialName(name)
	for i = 1, #config.monsters do
		if string.instr(name, config.monsters[i]) then
			return true
		end	
	end
	return false	
end --> check is name is with special status

function switchMonsterIfPossible()
	for _, c in ipairs(Creature.iMonsters(config.range)) do
		if isSpecialName(c.name) then
			Creature.Attack(c.id)
			return true
		end	
	end	
	return false
end	--> check for possible special monsters to attack and switch target.


Module.New("Prioritize Demonic or Ranged Mobs", function()
	if Self.isConnected() then
		local t = Self.TargetID()
		if t > 0 then
			local mob = Creature.getCreatures(t)
			if table.count(mob) > 1 then
				if not isSpecialName(mob.name) then switchMonsterIfPossible() end
			end
		else
			switchMonsterIfPossible()		
		end	
	end	
end)