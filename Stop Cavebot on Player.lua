--[[
    Script Name: 		Stop cavebot on Player
    Description: 		Stop cavebot when player out of friends list is on screen else enable.
    Author: 			Ascer - example
]]

local FRIENDS = {"friend1", "friend2"}                                              -- ignore this friend list.
local WHEN_PLAYER_LEAVE_SCREEN_ENABLE_BOT_AFTER = 5                                 -- enable bot when player leave screen after 5 seconds
local SAY_MESSAGE = {enabled = false, message = "i finish task here bro", delay = 3}  -- send message to player on appear, @enabled - true/false, @message - what to say, @delay - after player appear dont say instant

-- DONT'T EDIT BELOW THIS LINE 

local list, action = table.lower(FRIENDS), 0
local say, sayTime, sayTable = false, 0, {}

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getPlayer()
--> Description:    Read for non players on screen.
--> Class:          none
--> Params:         None
--> Return:         on success return table with player else nil
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPlayer()
    local players = Creature.iPlayers(9, false) -- get players on screen only
    for i = 1, #players do
        local player = players[i]
        if not table.find(list, string.lower(player.name)) then
            return player
        end
    end    
end    


Module.New("Stop cavebot on Player", function ()
	
    -- get player
    local player = getPlayer()
    
    -- read current state of walker and targeting
    local walker = Walker.isEnabled()
    local targeting = Targeting.isEnabled()
    
    -- when detected player before then executed say action
    if say then
        if os.clock() - sayTime > SAY_MESSAGE.delay then
            Self.Say(SAY_MESSAGE.message)
            say = false
        end  
    end    

    -- if player detected
    if table.count(player) > 0 then

        -- disable targeting and walker when enabled.
        if walker then Walker.Enabled(false) end
        if targeting then Targeting.Enabled(false) end

        -- check if we can say message
        if SAY_MESSAGE.enabled and not table.find(sayTable, player.name) and Creature.isOnScreen(player) then
            say = true
            sayTime = os.clock()
            table.insert(sayTable, player.name)
        end    

        -- save time
        action = os.clock()

    else

        -- when time diff between disable
        if os.clock() - action > WHEN_PLAYER_LEAVE_SCREEN_ENABLE_BOT_AFTER then

            -- enable targeting and walker.
            if not walker then Walker.Enabled(true) end
            if not targeting then Targeting.Enabled(true) end

        end   

    end    

end)
