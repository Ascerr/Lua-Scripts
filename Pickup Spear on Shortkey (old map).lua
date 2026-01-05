--[[
    Script Name:        Pickup Spear on Shortkey (old map)
    Description:        Will pickup spear from ground 1 sqm around you when you type Shortkey with command: EXECUTE scriptname
    Author:             Ascer - example
]]

local SPEAR_ID = 3277

-- DONT EDIT BELOW THIS LINE

local pos = Self.Position()
local weapon = Self.Weapon()
local cap = Self.Capity()

if weapon.id == 0 or weapon.id == SPEAR_ID then
	local map = Map.getArea(RANGE) -- load map with 1 sqm range
	for i, square in pairs(map) do
		local sqareItems = square.items
		for j, item in pairs(sqareItems) do
			if SPEAR_ID == item.id then
				local amount = item.count
				if amount * 20 > cap then 
					amount = math.floor(cap / 20)
				end		
				if amount > 0 then
					Self.EquipItemFromGround(SLOT_WEAPON, square.x, square.y, square.z, item.id, item.count, 150)
			    	break
			    end	
			end
		end			
	end
end	