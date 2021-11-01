--[[
    Script Name:        Do something if Stand time
    Description:        If stand time is above X do something.
    Author:             Ascer - example
]]

local config = {
	time = 5			-- how many seconds of stand time to do something.
}

-- DONT EDIT BELOW THIS LINE

local standTime, lastPos = 0, {x=0, y=0, z=0}

Module.New("Do something if Stand time", function()
	local pos = Self.Position()
	if pos.x ~= lastPos.x or pos.y ~= lastPos.y or pos.z ~= lastPos.z then
		standTime = os.clock()
	end
	lastPos = pos
	local diff = os.clock() - standTime
	-- do here you stuff diff store how many seconds elapsed from last position.
	if diff > config.time then
		print("stand time is " .. diff)
	end	
end)