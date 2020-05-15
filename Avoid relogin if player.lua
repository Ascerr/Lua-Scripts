--[[
    Script Name: 		Avoid relogin if player
    Description: 		If after relogin to game we see player lua stop bot and logout character.
    Author: 			Ascer - example
]]

local FRIENDS = {"Friend1", "Friend2"}		-- safe list of your mates with Capital letter.
local DISCONNECTION_TIME = 1				-- (minutes) how long we need to be offline to function check for player after relogin.	
local SEARCH_PLAYER_TIME = 10				-- (seconds) how long after relogin we will check for player.

-- DON'T EDIT BELOW THIS LINE

local logoutStartTime, checkForPlayer, checkForPlayerTime, forceLogout = 0, false, 0, false

---------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getPlayer()
--> Description:    Get player on screen.
--> Class:          Self
--> Params:         None              
--> Return:         boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPlayer()

    -- inside loop for all found players:
    for i, c in pairs(Creature.iPlayers(8, false)) do

        -- when we can not find a friends.
        if not table.find(FRIENDS, c.name) then
            
            -- show player.name
        	printf("Player Detected: " .. c.name)

            -- return creature.    
            return true

        end        
        
    end

    -- return false noone player found.
    return false

end 

-- main module with loop function
Module.New("Avoid relogin if player", function ()

	-- check for online status.
	local logged = Self.isConnected()

	-- when not force logout then
	if not forceLogout then

		-- when we are disconnected then
		if not logged then

			-- set logout start time.
			if logoutStartTime == 0 then logoutStartTime = os.clock() end

		-- when we are connected
		else
			
			-- if the incident with logout happen
			if logoutStartTime > 0 then

				-- check how long take this situation.
				if os.clock() - logoutStartTime >= (DISCONNECTION_TIME * 60) then

					-- set check for player at start function.
					checkForPlayer = true

					-- set time to calculate how long we will checking.
					checkForPlayerTime = os.clock()

				else
					
					-- rest time, we was short offline example lag in game.	
					logoutStartTime = 0

				end	

			end	

			-- when check for player is enabled.
			if checkForPlayer then

				-- when time difference is ok
				if os.clock() - checkForPlayerTime <= SEARCH_PLAYER_TIME then

					-- when player detected.
					if getPlayer() then

						-- set param logout true.
						forceLogout = true

					end

				else

					-- reset time and checking
					checkForPlayer = false
					checkForPlayerTime = 0	

				end	

			end
				
		end		

	else

		-- disable panel functions.
		Rifbot.setEnabled(false)

		-- when logged.
		if logged then 

			-- force logout.
			Self.Logout()

		else	

			-- reset params.
			forceLogout = false
			logoutStartTime = 0
			checkForPlayer = false
			checkForPlayerTime = 0

		end	

	end	

end)
