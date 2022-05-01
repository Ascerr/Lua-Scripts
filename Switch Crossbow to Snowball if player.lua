--[[
    Script Name:        Switch Crossbow to Snowball if player
    Description:        Switch weapon in slot, crossbow when 2+ monsters, snowball when player or low monsters. Friends list = list from bot panel 
    Author:             Ascer - example
]]


local config = {
    crossbow = 3347,		-- id of crossbow		
    snowball = 3277,		-- id of snowball
    monsters = 2			-- when this amount of monsters or higher then change to crossbow else snowball ofc when no players.
}

-- DON'T EDIT BELOW THIS LINE

-- load friend list
local friends = Rifbot.FriendsList(true)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       isPlayerOrLowMobs(mobAmount)
--> Description:    Check if is player on screen or low amount of monsters
--> Params:         
-->                 @mobAmount number min amount of monsters to wear crossbow
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function isPlayerOrLowMobs(mobAmount)
	local creatures = Creature.iCreatures(7, false)
	local mob = 0
	for i, c in ipairs(creatures) do
		if Creature.isPlayer(c) then
			if not table.find(friends, string.lower(c.name)) then
				return true
			end
		elseif Creature.isMonster(c) then
			mob = mob + 1
			if mob >= mobAmount then
				return false
			end	
		end	
	end	
	return true
end	

-- module 200ms delay
Module.New("Switch Crossbow to Snowball if player", function()
	
	-- when connected
	if Self.isConnected() then

		-- load weapon slot
		local weapon = Self.Weapon()

		-- load status
		local status = isPlayerOrLowMobs(config.monsters)

		-- set new weapon
		local newWeapon = config.snowball

		-- when no status set crossbow
		if not status then
			newWeapon = config.crossbow
		end	

		-- wear new weapon
		if weapon.id ~= newWeapon then
			Self.EquipItem(SLOT_WEAPON, newWeapon, 1, 0)    
		end

	end	

end)
