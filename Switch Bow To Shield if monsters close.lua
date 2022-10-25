--[[
    Script Name: 		Switch Bow To Shield if monsters close
    Description: 		Change one hand weapon to other depend on creatures name. 
    Author: 			Ascer - example
]]

local config = {
	bow = 3350,							-- id of first default weapon (wear it also when no target) 
	shield = 3425,						-- id of second weapon we will wear if attacking monsters from list below.
	monsters = {"rotworm", "spider"},	-- list of monsters to wear second weapon.
	amount = 2,							-- how many monsters in (range) to wear shield.
	range = 1							-- distance between you and monsters to wear shield.
}

-- DON'T EDIT BELOW THIS LINE

-- change name to lower names
config.monsters = table.lower(config.monsters)

function getMonstersAound(range)
	local count = 0
	for _, c in ipairs(Creature.iMonsters(range)) do
		if table.find(config.monsters, string.lower(c.name)) then
			count = count + 1
		end
	end
	return count			
end	--> returns amount of monsters from config.monsters names in range

-- loop module function
Module.New("Switch Bow To Shield if monsters close", function ()
	if Self.isConnected() then
		if getMonstersAound(config.range) >= config.amount then
			if Self.Weapon().id ~= config.shield then
				Self.EquipItem(SLOT_WEAPON, config.shield, 1, math.random(300, 500))
			end
		else	
			if Self.Weapon().id ~= config.bow then
				Self.EquipItem(SLOT_WEAPON, config.bow, 1, math.random(300, 500))
			end
		end	
	end
end)
