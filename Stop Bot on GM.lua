--[[
    Script Name: 		Stop Bot on GM
    Description: 		Stop bot when GM without invisible mode detected.
    Author: 			Ascer - example
]]

local UNPAUSE_AFTER_SECONDS = 60    -- enable bot after 60s


-- DONT'T EDIT BELOW THIS LINE 
local detectTime = 0


Module.New("Stop Bot on GM", function ()
    local players = Creature.iPlayers(7, false) -- get players on screen only
    for i = 1, #players do
        local player = players[i]
        if string.instr(player.name, "GM ") or string.instr(player.name, "CM ") or string.instr(player.name, "Admin ") or string.instr(player.name, "ADM ") then
            Rifbot.PlaySound("Default.mp3") -- play sound
            detectedTime = os.clock()
            return Rifbot.setEnabled(false)
        end
    end
    -- enable bot after period of time.
    if detectedTime > 0 then
        if os.clock() - detectedTime > UNPAUSE_AFTER_SECONDS then
            if not Rifbot.isEnabled() then
                Rifbot.setEnabled(true)
            end    
        end    
    end    
end)
