--[[
    Script Name: 		Attack only monsters with full hp
    Description: 		Attack monsters with 100% hp, checking list and range.
    Author: 			Ascer - example
]]

local MONSTERS = {"troll", "rat"}			-- monsters list to attack
local RANGE = 5								-- range sqms to check
local DELAY = {100, 200}					-- attack random delay

-- DON'T EDIT BELOW THIS LINE

MONSTERS = table.lower(MONSTERS)

function getTarget()
	local creatures = Creature.iMonsters(RANGE, false) 
	for i = 1, #creatures do
		local creature = creatures[i]
		if table.find(MONSTERS, string.lower(creature.name)) and creature.hpperc == 100 then
			return creature
		end		
	end
	return -1
end	


Module.New("Attack only monsters with full hp", function(mod)
	if Self.isConnected() then
		local t = Self.TargetID()
		if t <= 0 then
			local target = getTarget()
			if table.count(target) > 1 then
				Creature.Attack(target.id)
			end	
		end	
	end
	mod:Delay(DELAY[1], DELAY[2])	
end)
