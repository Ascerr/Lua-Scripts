--[[
    Script Name: 		Pseudo looter (old map)
    Description: 		{Only for classic tibie 7.4 game client not for newer otclient}. Use map ground based on last target position if it will open 50-80% corpses will success.
    Author: 			Ascer - example
]]

local USE_MOUSE_TO_OPEN = true


-- DON'T EDIT BELOW


local lastT = -1

function test()
	local t = Self.TargetID()
	if t > 0 then
		local c = Creature.getCreatures(t)
		if table.count(c) > 0 then
			if table.count(lastT) > 0 then
				if lastT.id ~= c.id then
					wait(1000)
					if USE_MOUSE_TO_OPEN then 
						MouseOpenCorpse(lastT.x, lastT.y)
					else	
						Map.UseItem(lastT.x, lastT.y, lastT.z, getPseudoTop(lastT.x, lastT.y, lastT.z), 0, 0)
					end	
					lastT = -1
				end
			end		
			lastT = c
		end
	else		
		if table.count(lastT) > 0 then
			wait(1000)
			if USE_MOUSE_TO_OPEN then 
				MouseOpenCorpse(lastT.x, lastT.y)
			else
				Map.UseItem(lastT.x, lastT.y, lastT.z, getPseudoTop(lastT.x, lastT.y, lastT.z), 0, 0)
			end	
			lastT = -1
		end	
	end	
end	

function getPseudoTop(x, y, z)
	local map = Map.getArea(2) -- load map with 2 sqm range
	for i, square in pairs(map) do
		if square.x == x and square.y == y and square.z == z then
			local sqareItems = square.items
			local idt = 0
			for j, item in pairs(sqareItems) do
				idt = item.id	
			end
			return idt
		end			
	end
end	

function MouseOpenCorpse(x, y)
	local pos = Rifbot.GetMousePosFromGround(x, y)
	Rifbot.MouseClick(pos.x, pos.y+20, 1)
end	--> open cropse using right click


Module.New("Pseudo looter (old map)", function()
	test()
end)

