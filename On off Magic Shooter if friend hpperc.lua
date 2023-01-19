--[[
    Script Name: 		On off Magic Shooter if friend hpperc
    Description: 		When some of your friend have low hpperc then disable magic shooter else enable.
    Author: 			Ascer - example
]]

local config = {
	friendHpperc = 70		-- below this % value magic shooter will be off (don't counting your character)
}

-- DON'T EDIT BELOW THIS LINE

function friendHaveLowHpperc(perc)
	local friends = Rifbot.FriendsList(true)
	for _, f in ipairs(Creature.iPlayers(7, false)) do
		if table.find(friends, string.lower(f.name)) then
			if f.hpperc <= perc then return true end
		end
	end
	return false	
end --> check if some of your friends have low hpperc


Module.New("On off Magic Shooter if friend hpperc", function()
	if Self.isConnected() then
		if friendHaveLowHpperc(config.friendHpperc) then
			Rifbot.setCheckboxState("cavebot", "magic shooter", false)
		else	
			Rifbot.setCheckboxState("cavebot", "magic shooter", true)
		end
	end	
end)