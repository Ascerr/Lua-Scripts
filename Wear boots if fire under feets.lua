--[[
    Script Name:        Wear boots if fire under feets
    Description:        When your character will walk on fire then will wear special boots else normal.
    Author:             Ascer - example
]]

local config = {
	fireSqm = {2121, 2122, 2123, 2124}, -- ids of ground fire.
	fireBoots = 1234,					-- id of fire boots
	normalBoots = 3552					-- id of standard boots.
}


-- DON'T EDIT BELOW

Module.New("Wear boots if fire under feets", function ()
	if Self.isConnected() then
		local me = Self.Position()
		local map = Map.GetItems(me.x, me.y, me.z)
		local isFire = false
		for _, item in ipairs(map) do
			if table.find(config.fireSqm, item.id) then
				isFire = true
				break
			end 
		end
		local boots = Self.Feet()
		if isFire then
			if boots.id ~= config.fireBoots then
				Self.EquipItem(SLOT_FEET, config.fireBoots, 1)
			end	
		else
			if boots.id ~= config.normalBoots then
				Self.EquipItem(SLOT_FEET, config.normalBoots, 1)
			end	
		end	
	end		
end) 