--[[
    Script Name: 		Keep Follow Friend
    Description: 		Keep follow for friend on map (only this same level) with specific range
    Required:           Rifbot 1.94 + (2021-08-03)
    Author: 			Ascer - example
]]

local config = {
    player = "Player Name",          -- player name we follow
    dist = 2,                   -- distance between player and you (min 1, max 4 sqms)
    fastwalking = false         -- enter critical section to run faster
}

-- DON'T EDIT BELOW THIS LINE

-- set fast walking
if config.fastwalking then
    Rifbot.setCriticalMode(true)
end    

-- module 200ms
Module.New("Keep Follow Friend", function ()
    
    -- load players
    for i, player in ipairs(Creature.iPlayers(9, false)) do

        -- when player name is this same as we looking for.
        if string.lower(player.name) == string.lower(config.player) then

            -- set default mode
            local range = "follow"

            -- set range
            if config.dist == 2 then
                range = "2sqm"
            elseif config.dist == 3 then
                range = "3sqm"
            elseif config.dist == 4 then
                range = "4sqm" 
            end   

            -- follow creature
            Creature.Reach(player, range)

            -- break loop
            break

        end 

    end 

end)
