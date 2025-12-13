--[[
    Script Name:        Mouse Walking 
    Description:        Walking on ground from wpt to wpt using mouse click
    Author:             Ascer - example
]]

local waypoints = {										-- wpts list, possible: stand, node, weak node. position must be visible on screen to character will able click on ground so every 5 sqms is good idea
	{i = "node", x = 32098, y = 32194, z = 7},
	{i = "stand", x = 32098, y = 32190, z = 7},
	{i = "node", x = 32098, y = 32193, z = 6},
	{i = "stand", x = 32098, y = 32190, z = 6}
}

local backgroundClick = true -- click mouse in background mode (true) or real mouse simulation = lock screen (false)

local clickDelay = 1 -- seconds between mouse click if not walking 


-- EDIT ONLY IF YOU KNOW WHAT YOU DOING.

local index, clickTime = 1, 0

function walk()
	if index > table.count(waypoints) then
		index = 1
	end	
	local wpt = waypoints[index]
	wpt.i = string.lower(wpt.i)
	local dist = 0
	if wpt.i == "node" then
		dist = 1
	elseif wpt.i == "weak node" then
		dist = 2	
	end	
	if Self.DistanceFromPosition(wpt.x, wpt.y, wpt.z) <= dist then 
		--print("ignore due reached")
		index = index + 1
		return
	end	
	local me = Self.Position()
	if (math.abs(wpt.x - me.x) > 7 or math.abs(wpt.y - me.y) > 5 or math.abs(wpt.z - me.z) > 0) then
		--print("ignore wpt due out of sceen.")
		index = index + 1
		return
	end
	local pixels = Rifbot.GetMousePosFromGround(wpt.x, wpt.y)
	if table.count(pixels) > 0 and not Self.isWalking() then
		if pixels.x > 0 then
			if os.clock() - clickTime > clickDelay then
				--print("click", pixels.x, pixels.y)
				Rifbot.MouseClick(pixels.x, pixels.y, 0, backgroundClick)
				clickTime = os.clock()
			end
		else		
			--print("ignore wpt due out of sceen 2.")
			index = index + 1
			return
		end
	end		
end	

-- Loop module
Module.New("Mouse Walking", function()
	if Self.isConnected() then
		if Self.TargetID() <= 0 then -- walk only if no target
			walk()
		end	
	end	
end)