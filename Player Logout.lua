--[[
    Script Name: 		Player Logout
    Description: 		Logout your character when player detect on (range: x = [-8, 9], y = [-6, 7]).
    Author: 			Ascer - example
]]

local SAFE_LIST = {"friend1", "friend2"} -- set a safe list

Module.New("Player Logout", function (mod)
    if Self.isConnected() then
        local players = Creature.iPlayers(9, false) -- get players with max range only on my floor
        for i = 1, #players do
            local player = players[i]
            if not table.find(SAFE_LIST, player.name) then
                Self.Logout()
                Rifbot.ConsoleWrite("[" .. os.date("%X") .. "] logged due a player detected: " .. player.name) -- set message to Rifbot Console.
                break
            end
        end
    end
    mod:Delay(200) -- set module execution 200ms (Can not be fast than 200ms!)
end)
