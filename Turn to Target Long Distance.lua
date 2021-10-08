--[[
    Script Name: 		Turn to Target Long Distance
    Description: 		When you attackng monster character will turn face to it using long distance.
    Author: 			Ascer - example
]]

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		turnToTarget()
--> Description: 	Turn face to target use for long distance
--> Class: 			None
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function turnToTarget()

	-- load target.
	local t = Self.TargetID()

	-- when no target return
	if t <= 0 then return false end

	-- creature.	
	local c = Creature.getCreatures(t)

	-- load self
	local me = Self.Position()

	-- calc distance between creature and you.
	local diffx = math.abs(c.x - me.x)
	local diffy = math.abs(c.y - me.y)

	-- set basic turn
	local turn = -1

	-- check where will trun
	if diffx > diffy then

		-- turn east or west
		if c.x - me.x >= 0 then
			turn = 1
		else 
			turn = 3	
		end	

	else

		-- turn north or south
		if c.y - me.y >= 0 then
			turn = 2
		else
			turn = 0
		end		

	end

	-- when dir is set
	if turn ~= -1 then

		-- when no this dir turn
		if Self.Direction() ~= turn then

			return Self.Turn(turn)

		end	

	end	

end	

-- module loop.
Module.New("Turn to Target Long Distance", function()

	turnToTarget()

end)