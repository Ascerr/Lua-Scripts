--[[
    Script Name:        Pickup Separ on Shortkey
    Description:        Will pickup spear from ground 1 sqm around you when you type Shortkey with command: EXECUTE scriptname
    Author:             Ascer - example
]]

local SPEAR_ID = 3277

-- DONT EDIT BELOW THIS LINE

local pos = Self.Position()
local weapon = Self.Weapon()
local cap = Self.Capity()

if weapon.id == 0 or weapon.id == SPEAR_ID then
	for x = -1, 1 do
		for y = -1, 1 do
			local map = Map.GetTopMoveItem(pos.x+x, pos.y+y, pos.z)
			if map.id == SPEAR_ID then
				local amount = map.count
				if amount * 20 > cap then 
					amount = math.floor(cap / 20)
				end		
				if amount > 0 then
					Self.EquipItemFromGround(SLOT_WEAPON, pos.x+x, pos.y+y, pos.z, SPEAR_ID, amount, 150)
			    	break
			    end		
	        end	
		end
	end	
end		

