--[[
    Script Name:        Mouse Walking 
    Description:        Walking on ground from wpt to wpt using mouse click. 
    					Possible and recomended to record waypoints using Module.New("Record Nodes", function(). At the end of module remove: , false. Wpts will stored in this same folder as bot file: wpt.txt then just copy to this script 
    Author:             Ascer - example
]]

local waypoints = {										-- wpts list, possible: {stand, node, weak node, use, wait} position must be visible on screen to character will able click on ground so every 5 sqms is good idea and not under roof
	{i = "node", x = 32115, y = 32244, z = 8},
	{i = "node", x = 32114, y = 32240, z = 8},
	{i = "node", x = 32114, y = 32236, z = 8},
	{i = "node", x = 32118, y = 32234, z = 8},
	{i = "node", x = 32122, y = 32234, z = 8},
	{i = "node", x = 32126, y = 32236, z = 8},
	{i = "wait", x = 1000, y = 32236, z = 8},
	{i = "node", x = 32134, y = 32235, z = 8},
	{i = "stand", x = 32137, y = 32239, z = 8},
	{i = "node", x = 32138, y = 32243, z = 8},
	{i = "node", x = 32134, y = 32246, z = 8},
	{i = "use", x = 32130, y = 32248, z = 8},
	{i = "node", x = 32126, y = 32249, z = 8},
	{i = "node", x = 32122, y = 32249, z = 8},
	{i = "weak node", x = 32118, y = 32248, z = 8},
	{i = "node", x = 32114, y = 32245, z = 8}
}



local backgroundClick = true 					-- click mouse in background mode (true) or real mouse simulation = lock screen (false)
local afterKillDelay = 2 						-- seconds to wait after kill monster to continue walking.
local clickDelay = 1 							-- seconds between mouse click if not walking 

-- EDIT BELOW ONLY IF YOU KNOW WHAT YOU DOING.

local index, clickTime, targetTime, lastPos, allWpt, showAllWptTime, forceClick = 1, 0, 0, {x = 0, y = 0, z =0}, "", 0, false
local logsPath = string.sub(FRIENDS_PATH, 1, -12) .. "wpt.txt"


function walk()
	if index > table.count(waypoints) then
		index = 1
	end	
	local wpt = waypoints[index]
	wpt.i = string.lower(wpt.i)
	if wpt.i == "wait" then
		wait(wpt.x)
		return nextWpt()
	end	
	local dist = 0
	if wpt.i == "node" then
		dist = 1
	elseif wpt.i == "weak node" then
		dist = 2	
	end	
	local me = Self.Position()
	if wpt.i == "use" then
		if math.abs(wpt.z - me.z) > 0 then
			--print("ignore due different floor")
			return nextWpt()
		end	
	else	
		if Self.DistanceFromPosition(wpt.x, wpt.y, wpt.z) <= dist then 
			--print("ignore due reached")
			return nextWpt()
		end	
	end	
	if (math.abs(wpt.x - me.x) > 7 or math.abs(wpt.y - me.y) > 5 or math.abs(wpt.z - me.z) > 0) then
		--print("ignore wpt due out of sceen.")
		return nextWpt()
	end
	local pixels = Rifbot.GetMousePosFromGround(wpt.x, wpt.y)
	if table.count(pixels) > 0 and (not Self.isWalking() or forceClick) then
		if pixels.x > 0 then
			if os.clock() - clickTime > clickDelay then
				--print("click", pixels.x, pixels.y)
				if backgroundClick then
					pixels.y = pixels.y + 20
				end	
				local side = 0
				if wpt.i == "use" then side = 1 end	
				Rifbot.MouseClick(pixels.x, pixels.y, side, backgroundClick)
				forceClick = false
				clickTime = os.clock()
			end
		else		
			--print("ignore wpt due out of sceen 2.")
			nextWpt()
			return
		end
	end		
end	

function nextWpt()
	forceClick = true
	index = index + 1
end --> actions related to switch next wpt

function fileAppend(path, data)
	file = io.open(path, 'a')
	file:write(data)
	return file:close()
end --> append new data at the end of file


-- Loop module
Module.New("Mouse Walking", function()
	if Self.isConnected() then
		if Self.TargetID() <= 0 then -- walk only if no target
			if os.clock() - targetTime >= afterKillDelay then
				walk()
			end	
		else	
			targetTime = os.clock()
		end	
	end	
end)


Module.New("Record Nodes", function()
	if Self.isConnected() then
		if lastPos.x == 0 then 
			local startData = "[" .. os.date("%X") .. "] Recording nodes..\n"
			fileAppend(logsPath, startData) 
			print(startData)
			print("Waypoints are stored at location: " .. logsPath) 
		end
		if Self.DistanceFromPosition(lastPos.x, lastPos.y, lastPos.z) >= 4 then -- record every 4 sqm to be able click on map
			local me = Self.Position()
			lastPos = me
			local wptString = '{i = "node", x = ' .. me.x .. ", y = " .. me.y .. ", z = " .. me.z .. "},"
			print(wptString)
			fileAppend(logsPath, wptString .. "\n")
		end
	end	
end, false) -- default disabled it's only for record nodes.


