--[[
    Script Name: 		Switch weapon on Creature
    Description: 		Change one hand weapon to other depend on creatures name. 
    Author: 			Ascer - example
]]


local config = {
	first = {weapon = 3273, shield = 3426},						-- id of first default weapon and shield
	second = {weapon = 3277, shield = 0},						-- id of second weapon (if no shield weapon is two handed type shield = 0)
	amount = 2,													-- minimal amount of monsters to wear second weapon
	range = 3,													-- max distance between you and monster to wear second weapon
	monsters = {"rat", "spider"}								-- list of monsters to wear second weapon.
}


-- DON'T EDIT BELOW THIS LINE

-- change name to lower names
config.monsters = table.lower(config.monsters)


function canWearSecondWeapon()
	local count = 0
	for _, c in ipairs(Creature.iMonsters(config.range)) do
		if table.find(config.monsters, string.lower(c.name)) then
			count = count + 1
			if count >= config.amount then return true end
		end	
	end
	return false	
end	--> Check if can change weapon to second (enough monsters in range)

function switchWeapon(switchWeapon, switchShield)
	local weapon = Self.Weapon()
	local shield = Self.Shield()
	if weapon.id == switchWeapon then 
		if switchShield > 0 then
			if shield.id ~= switchShield then
				Self.EquipItem(SLOT_SHIELD, switchShield, 1, 500)
			end
		else
			if shield.id > 0 then
				Self.DequipItem(SLOT_SHIELD)
			end
		end
	else
		if switchShield == 0 then
			if shield.id > 0 then
				Self.DequipItem(SLOT_SHIELD)
			else	
				if weapon.id ~= switchWeapon then
					Self.EquipItem(SLOT_WEAPON, switchWeapon, 1, 500)
				end	
			end
		else	
			if weapon.id ~= switchWeapon then
				Self.EquipItem(SLOT_WEAPON, switchWeapon, 1, 500)
			end	
		end			
	end	
end	--> Switch weapon and shield in slots

Module.New("Switch weapon on Creature", function ()
	if Self.isConnected() then
		if canWearSecondWeapon() then
			switchWeapon(config.second.weapon, config.second.shield)
		else
			switchWeapon(config.first.weapon, config.first.shield)
		end
	end	
end)
