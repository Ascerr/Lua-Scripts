--[[
    Script Name:        Drop Fish when Cap
    Description:        Drop fish or other items under your character when reach limit capity from equipment and containers. 
    Author:             Ascer - example
]]

local FISH = {2667, 2668}			-- items to drop
local CAPITY = 50					-- when below capity drop fish
local DROP_DELAY = {500, 1700} 		-- time between actions

-- DON'T EDIT BELOW THIS LINE

Module.New("Drop Fish when Cap", function()
	if Self.Capity() < CAPITY then
		local pos = Self.Position()
		local fishInContainers = Container.FindItem(FISH)
		if table.count(fishInContainers) > 1 then
			Self.DropItem(pos.x, pos.y, pos.z, fishInContainers.id, 100) -- we drop 100 this mean when will below this value drop full stack.
		else	
			local weapon, shield, ammo, toDrop = Self.Weapon().id, Self.Shield().id, Self.Ammo().id, 0
			-- check for eq slots
			if table.find(FISH, weapon) then toDrop = weapon end
			if table.find(FISH, shield) then toDrop = shield end
			if table.find(FISH, ammo) then toDrop = ammo end
			if toDrop > 0 then
				Self.DropItem(pos.x, pos.y, pos.z, toDrop, 100) -- we drop 100 this mean when will below this value drop full stack.
			end	
		end	
	end
	mod:Delay(DROP_DELAY[1], DROP_DELAY[2])	-- mod delay
end)
