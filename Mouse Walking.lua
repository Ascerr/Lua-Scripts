--[[
    Script Name:        Mouse Walking 
    Description:        Walking on ground from wpt to wpt using mouse click. 
    					Possible and recomended to record waypoints using Module.New("Record Nodes", function(). At the end of module remove: , false. Wpts will stored in this same folder as bot file: wpt.txt then just copy to this script 
    					Example how to properly fill wpts:
							{i = "node", x = 32124, y = 32249, z = 8},
							{i = "weak node", x = 32124, y = 32249, z = 8},
							{i = "stand", x = 32124, y = 32249, z = 8},
							{i = "use", x = 32124, y = 32249, z = 8},
							{i = "usewith", x = 32116, y = 32246, z = 8, id = 3003},
							{i = "wait", x = 1000},
							{i = "label", x = "hunt"},
							{i = "goto", x = "hunt"}, -- it only go to selected label without checking for any condition
							{i = "lua", x = 'if Self.Cap() > 10 then Walker.Goto("back") end'},

    Author:             Ascer - example
]]

-- CONFIG SECTION: START

local backgroundClick = true 							-- click mouse in background mode (true) or real mouse simulation = lock screen (false)
local afterKillDelay = 2.5 								-- seconds to wait after kill monster to continue walking.
local clickDelay = 1 									-- seconds between mouse click if not walking 
local recordNodes = false								-- default false, it can record walking on map one floor, not stands only nodes. Setting = true it enabling module Module.New("Mouse Walking", function() end) and waypoint will store inside Bot folder\wpt.txt then copy it to this lua script
local walkerStuck = {enabled = true, time = 15} 		-- play sound if stuck time 15s or more

local waypoints = {										-- wpts list position must be visible on screen to character will able click on ground so every 5 sqms is good idea and not under roof
{i = "node", x = 32098, y = 32212, z = 7},				-- waypoints rookgaard south east house (starts in temple)
{i = "node", x = 32102, y = 32212, z = 7},
{i = "node", x = 32106, y = 32212, z = 7},
{i = "node", x = 32107, y = 32216, z = 7},
{i = "node", x = 32107, y = 32220, z = 7},
{i = "node", x = 32107, y = 32224, z = 7},
{i = "node", x = 32107, y = 32228, z = 7},
{i = "node", x = 32109, y = 32232, z = 7},
{i = "node", x = 32109, y = 32236, z = 7},
{i = "node", x = 32110, y = 32240, z = 7},
{i = "stand", x = 32110, y = 32242, z = 7},
{i = "stand", x = 32110, y = 32245, z = 7},
{i = "label", x = "hunt"},
{i = "node", x = 32114, y = 32244, z = 8},
{i = "node", x = 32114, y = 32240, z = 8},
{i = "node", x = 32114, y = 32236, z = 8},
{i = "node", x = 32118, y = 32234, z = 8},
{i = "node", x = 32122, y = 32235, z = 8},
{i = "node", x = 32126, y = 32236, z = 8},
{i = "node", x = 32130, y = 32236, z = 8},
{i = "node", x = 32134, y = 32235, z = 8},
{i = "node", x = 32137, y = 32239, z = 8},
{i = "node", x = 32138, y = 32243, z = 8},
{i = "node", x = 32136, y = 32247, z = 8},
{i = "node", x = 32132, y = 32248, z = 8},
{i = "node", x = 32128, y = 32248, z = 8},
{i = "node", x = 32124, y = 32249, z = 8},
{i = "node", x = 32120, y = 32249, z = 8},
{i = "node", x = 32116, y = 32246, z = 8},
{i = "goto", x = "hunt"}
}

-- CONFIG SECTION: START

-- EDIT BELOW ONLY IF YOU KNOW WHAT YOU DOING.

local index, clickTime, targetTime, lastPos, allWpt, showAllWptTime, forceClick, recordMod = 1, 0, 0, {x = 0, y = 0, z =0}, "", 0, false, 0
local logsPath = string.sub(FRIENDS_PATH, 1, -12) .. "wpt.txt"
local lastMyPos, lastMyPosTime = Self.Position(), os.clock()

function walk()
	if index > table.count(waypoints) then
		index = 1
	end	
	local wpt = waypoints[index]
	wpt.i = string.lower(wpt.i)
	if wpt.i == "wait" then
		wait(wpt.x)
		return nextWpt()
	elseif wpt.i == "label" then
		return nextWpt()
	elseif wpt.i == "goto" then
		return nextWpt(wpt.x)
	elseif wpt.i == "lua" then
		local script = loadstring
		local script, err = loadstring(wpt.x)
		if script then
			pcall(script)
		else	
			print("Lua wpt error: " .. err)
		end	
		return nextWpt()
	end	
	local dist = 0
	if wpt.i == "node" then
		dist = 1
	elseif wpt.i == "weak node" then
		dist = 2	
	end	
	local me = Self.Position()
	if wpt.i == "use" or wpt.i == "usewith" then
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
				if wpt.i == "usewith" then
					Self.UseItemWithGround(wpt.id, wpt.x, wpt.y, wpt.z, 0) -- force use without delay
					nextWpt()
					wait(1000) --> waits some time
					return 
				else	
					--print("click", pixels.x, pixels.y)
					if backgroundClick then
						pixels.y = pixels.y + 20
					end	
					local side = 0
					if wpt.i == "use" then side = 1 end	
					Rifbot.MouseClick(pixels.x, pixels.y, side, backgroundClick)
				end	
				forceClick = false	
				clickTime = os.clock()	
			end
		else		
			--print("Ignore WPT: index, type, x, y, z: ", index, wpt.i, wpt.x, wpt.y, wpt.z, "due out of screen -> failed to get mouse click pos")
			nextWpt()
			return
		end
	end		
end	

function nextWpt(label)
	if label ~= nil then
		for i, w in ipairs(waypoints) do
			if string.lower(w.i) == "label" then
				if string.lower(w.x) == string.lower(label) then
					forceClick = true
					index = i
					return
				end	
			end	
		end	
	else
		forceClick = true
		index = index + 1
	end	
end --> actions related to switch next wpt

--> rename official walker goto to new
Walker.Goto = nextWpt

function fileAppend(path, data)
	file = io.open(path, 'a')
	file:write(data)
	return file:close()
end --> append new data at the end of file

-- Loop module
Module.New("Mouse Walking", function()
	if table.count(recordMod) > 0 then
		if recordMod:IsActive() then return false end				-- DON'T ALLOW mouse walking if recording nodes. 
	end	
	if Self.isConnected() then
		if Self.TargetID() <= 0 then -- walk only if no target
			if os.clock() - targetTime >= afterKillDelay then
				walk()
			end	
		else	
			targetTime = os.clock()
			lastMyPosTime = os.clock()
		end			
	end	
end)

Module.New("Walker Stuck", function()
	if Self.isConnected() and walkerStuck.enabled and not recordNodes then
		local me = Self.Position()
		if me.x == lastMyPos.x and me.y == lastMyPos.y and me.z == lastMyPos.z then 
			if os.clock() - lastMyPosTime >= walkerStuck.time then
				if index <= table.count(waypoints) then
					local currWpt = waypoints[index]
					if string.lower(currWpt.i) ~= "wait" then
						Rifbot.PlaySound("Walker Stuck.mp3")
					end 
				end
			end	
		else
			lastMyPos = me
			lastMyPosTime = os.clock()
		end	
	end	
end)

-- register record nodes module default disabled.
recordMod = Module.New("Record Nodes", function()
	if Self.isConnected() then
		if lastPos.x == 0 then 
			local startData = "[" .. os.date("%X") .. "] Recording nodes..\n"
			fileAppend(logsPath, startData) 
			print(startData)
			wait(1000)
			print("Waypoints are stored at location: " .. logsPath) 
			wait(2000)
		end
		if Self.DistanceFromPosition(lastPos.x, lastPos.y, lastPos.z) >= 4 then -- record every 4 sqm to be able click on map
			local me = Self.Position()
			lastPos = me
			local wptString = '{i = "node", x = ' .. me.x .. ", y = " .. me.y .. ", z = " .. me.z .. "},"
			print(wptString)
			fileAppend(logsPath, wptString .. "\n")
		end
	end	
end, recordNodes) -- default disabled it's only for record nodes.


