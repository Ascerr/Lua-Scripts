--[[
    Script Name: 		Go House Make Rune and Back
    Description: 		When current mana level go to house make rune and back with alana sio. 
    Author: 			Ascer - example
]]

local HOUSE_POS = {x = 32335, y = 32245, z = 7} -- Position to go

local SPELL = {
	name = "adura vita",		-- spell name
	mana = 100					-- min mana to cast spell
}

local BACK_ON_FEET = {
	enabled = false,					-- true/false back on feet not using alana sio
	pos = {x = 32336, y = 32245, z = 7} -- back position
}

local WHEN_PLAYER_HIDE = {
	enabled = false,					-- true/false hide to house when player appear (ignore safe list from friends.txt)
	back = {enabled = true, delay = 6}	-- back true/false, delay time in minutes to back after.
}

-- DON'T EDIT BELOW THIS LINE

local spellTime, stepTime, friends, backTime, logTime, lastPlayer = 0, 0, Rifbot.FriendsList(true), 0, 0, ""


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		delayedStep(dir, delay)
--> Description: 	Step with delay	
--> Params:			
-->					@dir number direction to step
-->					@delay number miliseconds between steps.
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function delayedStep(dir, delay)
	if os.clock() - stepTime > (delay / 1000) then
		Self.Step(dir)
		stepTime = os.clock()
	end	
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		delayedSay(text, delay)
--> Description: 	Say text with delay.	
--> Params:			
-->					@text string message to say on default channel.
-->					@delay number miliseconds between say.
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function delayedSay(text, delay)
	if os.clock() - spellTime > (delay / 1000) then
		Self.Say(text)
		spellTime = os.clock()
	end	
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		delayedLog(text, delay)
--> Description: 	Add log to bot panel.	
--> Params:			
-->					@text string message to store in log.
-->					@delay number miliseconds between logs.
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function delayedLog(text, delay)
	if os.clock() - logTime > (delay / 1000) then
		printf(text)
		logTime = os.clock()
	end
end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getPlayer(pos)
--> Description: 	Get player on multiple floors.
--> Class: 			Self
-->					
--> Return: 		table with creature or false when failed.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPlayer()

	-- inside loop for all found creatures on multiple floors do:
	for i, player in pairs(Creature.iPlayers(7, false)) do

		-- when we can not find a friends and creature is player:
		if not table.find(friends, string.lower(player.name)) then

			-- return table with creature
			return player

	    end

	end

	-- return false noone player found.
	return false

end	



-- module to run function inside loop
Module.New("Go House Make Rune and Back", function ()
	
	-- when connected
	if Self.isConnected() then

		-- set param player to false
		local player = false	

		-- when player on screen
		if WHEN_PLAYER_HIDE.enabled then

			-- load player checking.
			player = getPlayer()

		end

		-- when player detected
		if player then

			-- load distance
			local dist = Self.DistanceFromPosition(HOUSE_POS.x, HOUSE_POS.y, HOUSE_POS.z)

			-- check if we are in house.
			if dist > 0 then
		
		        -- load direction to step.
		        local dir = Self.getDirectionFromPosition(HOUSE_POS.x, HOUSE_POS.y, HOUSE_POS.z, dist)

		        -- step to safe pos
		        delayedStep(dir, 550)

		    else
		    
		    	-- update time we spent in house
		    	backTime = os.clock()

		    	-- update logs
		    	delayedLog("Go to safe place due player: " .. player.name, 2000) 

		    	-- store last name
		    	lastPlayer = player.name  

		    end 

		else	

			-- load mana
			local mp = Self.Mana()

			-- when mana is above.
			if mp >= SPELL.mana then

				-- load distance
				local dist = Self.DistanceFromPosition(HOUSE_POS.x, HOUSE_POS.y, HOUSE_POS.z)

				-- check if we are in house.
				if dist <= 0 then

					-- say spell every 2.5s
					delayedSay(SPELL.name, 2500)

				else
		
		            -- load direction to step.
		            local dir = Self.getDirectionFromPosition(HOUSE_POS.x, HOUSE_POS.y, HOUSE_POS.z, dist)

		            -- step to safe pos
		            delayedStep(dir, 550)

		        end 

		    else
		    	
		    	-- set able to back
		    	local ableBack = true

		    	-- when return is enabeld after time
		    	if (WHEN_PLAYER_HIDE.enabled and WHEN_PLAYER_HIDE.back.enabled)  then

		    		-- load difference time
		    		local diff = (os.clock() - backTime)

		    		-- when diff is not enough
		    		if diff < (WHEN_PLAYER_HIDE.back.delay * 60) then

		    			-- set able back on false
		    			ableBack = false

		    			-- show info about back
		    			delayedLog("Step due: " .. lastPlayer .. ", back for " .. math.floor((WHEN_PLAYER_HIDE.back.delay * 60) - diff) .. "s..", 1000)

		    		end	

		    	end
		    	
		    	-- when able to back
		    	if ableBack then

			    	-- when back on feet is enabled
			    	if BACK_ON_FEET.enabled then

			    		-- check dist between return pos.
			    		local dist = Self.DistanceFromPosition(BACK_ON_FEET.pos.x, BACK_ON_FEET.pos.y, BACK_ON_FEET.pos.z)

			    		-- when dist is diff than 0
			    		if dist ~= 0 then

				    		-- load direction to step.
				            local dir = Self.getDirectionFromPosition(BACK_ON_FEET.pos.x, BACK_ON_FEET.pos.y, BACK_ON_FEET.pos.z, dist)

				            -- step to safe pos
				            delayedStep(dir, 550)

				        end    

			    	else	

				    	-- load distance
						local dist = Self.DistanceFromPosition(HOUSE_POS.x, HOUSE_POS.y, HOUSE_POS.z)

						-- when we have no more mana for cast spell and dist = 0 then back with alana sio.  
						if dist == 0 then

							-- say alana sio every 3s
							delayedSay("alana sio \"" .. Self.Name(), 3000)

						end 

					end	

				end	

			end

		end		

	end	

end)
