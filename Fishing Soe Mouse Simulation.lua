--[[
    Script Name:        Fishing Soe Mouse Simulation
    Description:        Mouse simulation right click on water.
    Author:             Ascer - example
]]

local config = {
	water = {x = 31819, y = 32384, z = 6},					-- position x, y, z water tile (1sqm near your character)
	delay = {4000, 5000},									-- delay in ms between usage
	background = true										-- use real mouse simulation (false) will lock your global mouse and required focused window or (true) background mouse.
}

-- DON'T EDIT BELOW THIS LINE
local tclock = 0
local tdelay = math.random(config.delay[1], config.delay[2])

Module.New("Fishing Soe Mouse Simulation", function()
	if Self.isConnected() then
		if os.clock() - tclock >= (tdelay/1000) then
			local pos = Rifbot.GetMousePosFromGround(config.water.x, config.water.y)
			if pos.x > 0 then
				Rifbot.MouseClick(pos.x, pos.y, 1, config.background)
				tclock = os.clock()
				tdelay = math.random(config.delay[1], config.delay[2])
			end	
		end
	end	
end)


