--[[
    Script Name:        On off targeting if item count
    Description:        When item count below x value disable targeting else enable.
    Author:             Ascer - example
]]

local config = {
	item = {id = 3277, count = 0} 		-- @item.id type here is from game, @item.count type here min amount to disable targeting, default 0
}


-- mod to run functions
Module.New("On off targeting if item count", function (mod)	
	
	local amount = Self.ItemCount(config.item.id)
	local weapon = Self.Weapon()
	local shield = Self.Shield()
	local ammo = Self.Ammo()

	if weapon.id == config.item.id then amount = amount + weapon.count end
	if shield.id == config.item.id then amount = amount + shield.count end
	if ammo.id == config.item.id then amount = amount + ammo.count end

	if amount > config.item.count then
		if not Targeting.isEnabled() then Targeting.Enabled(true) end
	else
		if Targeting.isEnabled() then Targeting.Enabled(false) end
	end	

end)			