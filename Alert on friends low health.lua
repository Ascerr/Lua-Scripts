--[[
    Script Name:        Alert on friends low health
    Description:       	When someone from bot friends list have low health it will play sound.
    Author:             Ascer - example
]]

local config = {
	hpperc = 50			-- when friend hpperc <= 50% then play sound
}

-- DON'T EDIT BELOW THIS LINE.
local friends = Rifbot.FriendsList(true)

-- Module working in loop.
Module.New("Alert on friends low health", function ()
	if Self.isConnected() then
		for _, c in ipairs(Creature.iPlayers(7, false)) do
			if table.find(friends, string.lower(c.name)) and c.hpperc <= config.hpperc then
				Rifbot.PlaySound("Low Health.mp3")
				print("Friend: " .. c.name .." low health: " .. c.hpperc .. "%")
				break
			end
		end	
	end	
end)