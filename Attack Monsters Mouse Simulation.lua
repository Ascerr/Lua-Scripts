--[[
    Script Name: 		Attack Monsters Mouse Simulation
    Description: 		Attack closest monsters using mouse simulation
    Author: 			Ascer - example
]]

local mobs = {"Rat", "Slime"}		-- monsters to attack
local background = true				-- true/false click in background (true) or real mouse move (false)
local distance = 7					-- range for detecing.

-- DON'T EDIT BELOW THIS LINE

mobs = table.lower(mobs)

function getClosestMonster()
	local range, mob = 20, nil
	for _, c in ipairs(Creature.iMonsters(distance, false)) do
		if table.find(mobs, string.lower(c.name)) then
			local dist = Creature.DistanceFromSelf(c)
			if dist < range then
				range = dist
				mob = c
			end
		end		
	end
	return mob	
end	

Module.New("Attack Monsters Mouse Simulation", function() 
	if Self.TargetID() <= 0 then
		local mob = getClosestMonster()
		if mob ~= nil then
			local pixels = Rifbot.GetMousePosFromGround(mob.x, mob.y)
			if table.count(pixels) > 0 then
				Rifbot.MouseClick(pixels.x, pixels.y, 1, background)
			end
		end	
	end	

end)
