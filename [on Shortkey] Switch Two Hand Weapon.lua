--[[
    Script Name:        [on Shortkey] Switch Two Hand Weapon
    Description:        Switch weapon in slot, its shortkey usage script type: EXECUTE name
    Author:             Ascer - example
]]


local config = {
    oneHand = 3286,		-- one hand weapon id
    shield = 3425,		-- shield
    twoHand = 3276		-- two hand weapon id
}

local shield, weapon, switch = Self.Shield(), Self.Weapon(), 0

if weapon.id == config.oneHand then
	switch = 0
elseif weapon.id == config.twoHand then
	switch = 1
end		

Module.New("[on Shortkey] Switch Two Hand Weapon", function(mod)
	shield, weapon = Self.Shield(), Self.Weapon()
	if switch == 0 then
		if shield.id > 0 then
			Self.DequipItem(SLOT_SHIELD, -1, -1, 0)
		else
			if weapon.id ~= config.twoHand then
				Self.EquipItem(SLOT_WEAPON, config.twoHand, 1, 0)
			else
				Rifbot.KillScript(selfScriptName)	
			end	
		end	
	else
		if weapon.id ~= config.oneHand then
			Self.EquipItem(SLOT_WEAPON, config.oneHand, 1, 0)
		else
			if shield.id ~= config.shield then
				Self.EquipItem(SLOT_SHIELD, config.shield, 1, 0)
			else
				Rifbot.KillScript(selfScriptName)
			end	
		end		
	end
end)