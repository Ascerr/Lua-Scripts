--[[
    Script Name: 		Player on Screen go to label
    Description: 		When player appear on screen for some time go to label.
    Author: 			Ascer - example
]]

local config = {
	safeList = {"Friend1", "Friend2"},		-- list of players to ignore
	label = "safe place",					-- label name we go when player attack us. 
	secondsAppearOnScreen = 2,				-- minimal amount of seconds player/s stay on screen to play sound.
	canReadCheckAgainForMins = 10			-- how many minutes to enable re-checking for player attacking when we already go to label.

}	

-- DONT EDIT BELOW THIS LINE.

local changedLabel, changeTime, isPlayerTime = false, 0, 0 
config.safeList = table.lower(config.safeList)

function getPlayer()
	
	-- for players on screen
	for i, player in ipairs(Creature.iPlayers(7, false)) do

		-- when player is not in friend list
		if not table.find(config.safeList, string.lower(player.name)) then

			-- is player return
			return player

		end 	

	end

	-- no player return -1
	return -1

end	



-- module to run function
Module.New("Player on Screen go to label", function ()

	-- when label is set.
	if changedLabel then

		-- when time diff is good
		if os.clock() - changeTime > (config.canReadCheckAgainForMins * 60) then

			-- reset param.
			changedLabel = false

		end	

	end	

	-- when we are connected
	if Self.isConnected() then
        
	    -- load players
	    local player = getPlayer()

	    -- when is player
	    if player ~= 1 then

	    	-- when time is 0 set new time
	    	if isPlayerTime == 0 then

	    		-- set time
				isPlayerTime = os.clock()

	    	end	

	    	-- when time is above minimal amount
	    	if os.clock() - isPlayerTime >= config.secondsAppearOnScreen then

				-- when we don't changed label then
				if not changedLabel then

					-- show info.
					print("Goto label due player: " .. player.name)

					-- go to label
					Walker.Goto(config.label)

					-- set.
					changedLabel = true
					changeTime = os.clock()

				end	

			end	

	    else

	    	-- reset time
	    	isPlayerTime = 0

	    end		
	    	
	end

end)
