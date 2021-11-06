--[[
    Script Name: 		Stop Bot on GM
    Description: 		Stop bot when GM without invisible mode detected.
    Author: 			Ascer - example
]]


-- DONT'T EDIT BELOW THIS LINE 

Module.New("Stop Bot on GM", function ()
	local players = Creature.iPlayers(7, false) -- get players on screen only
    for i = 1, #players do
        local player = players[i]
        if string.instr(player.name, "GM ") or string.instr(player.name, "CM ") or string.instr(player.name, "Admin ") or string.instr(player.name, "ADM ") then
            Rifbot.PlaySound("Default.mp3") -- play sound
            return Rifbot.setEnabled(false)
        end
    end
end)
