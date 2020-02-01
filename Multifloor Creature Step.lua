--[[
    Script Name: 		Multifloor Creature Step
    Description: 		Step to safe position when detect creature on multifloors.
    Required:			Valid position of safe pos example house door and pos to return sqm front of house. To get this position go to Rifbot -> Options -> GetCurrentPos
    Author: 			Ascer - example
]]

local FRIENDS = {"friend1", "friend2"} 										-- list of friends
local BELOW = true															-- check for players below you
local ABOVE = false															-- check for player above you
local LEVELS = 1															-- search for one floor above or below / limit is 2 / do not check floors below on level 7. To search only on your floor put 0.
local SAFE_POS = {32323, 32263, 6}											-- safe position to step when player detected {x, y, z}
local STEP_BACK = {enabled = true, pos = {32318, 32263, 6}, delay = 0.1} 	-- return to previus position when will safe, @eabled - true/false, @pos - {x, y, z}, @delay - minutes
local RECCONNECT = true														-- reconnect to game when lost connection or game issue @true/false
local USE_ON_MULTIPLE_CHARS = false											-- false or true if true then char will use x2 step to go into door and alana sio to out of house.

-- DON'T EDIT BELOW THIS LINE

-- convert table to lower strings.
FRIENDS = table.lower(FRIENDS) 

-- declare global vars
stepTime, printfTime, stepDate, lastPlayer = 0, 0, "", ""


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getPlayer(pos)
--> Description: 	Get player on multiple floors.
--> Class: 			Self
--> Params:			
-->					@pos - an array returned by Self.Position()
-->					
--> Return: 		table with creature or false when failed.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPlayer(pos)

	-- load self id.
	local selfName = Self.Name()

	-- inside loop for all found creatures on multiple floors do:
	for i, player in pairs(Creature.getCreatures()) do

		-- when we can not find a friends and creature is player:
		if not table.find(FRIENDS, string.lower(player.name)) and not Creature.isNpc(player) and player.name ~= selfName then
			
			-- load complicated var to check which players we searching, above, belowe or both and also amount of levels
			local var = (BELOW and (pos.z - player.z) <= 0 and (pos.z - player.z) >= (-LEVELS)) or (ABOVE and (pos.z - player.z) >= 0 and (pos.z - player.z) <= LEVELS)
			
			-- when var contains true a player was found
			if var then

				
				-- return table with creature
				return player

				
			end
	        end

	end

	-- return false noone player found.
	return false

end	


-- Start with module loop 200ms
Module.New("Multifloor Creature Step", function (mod)

	-- when my char is connected to game
	if Self.isConnected() then

		-- load self position
		local selfpos = Self.Position()

		-- call function to get player
		local player = getPlayer(selfpos)

		-- when var: player is different than false we found a player.
		if player ~= false then

			-- when creature is range x = {-7, 7} y = {-5, 5} to avoid stuck on step.
			if math.abs(player.x - selfpos.x) <= 7 and math.abs(player.y - selfpos.y) <= 5 then

				-- load distance between safe position and your character.
				local distance = Self.DistanceFromPosition(SAFE_POS[1], SAFE_POS[2], SAFE_POS[3])

				-- when distance will above 0:
				if distance > 0 then

					-- load a direction to step.
					local dir = Self.getDirectionFromPosition(SAFE_POS[1], SAFE_POS[2], SAFE_POS[3], distance)

					-- step to direction.
					Self.Step(dir)
					
					-- when we use it on multiple chars
					if USE_ON_MULTIPLE_CHARS then
					  	
						-- wait some time 
						wait(200)
						
						-- extra step
						Self.Step(dir)
							
					end
						
					-- show message about stepping.
					printf("Stepping to safe pos due a player: " .. player.name)

					-- set player.name and date
					stepTime = os.time()
					lastPlayer = player.name

					-- wait some time to avoid over dashing.
					wait(500, 1000)

				-- we are on safe pos.
				else	

					-- when stepDate is contains empty string set display params.
					if stepDate == "" then 

						-- set date
						stepDate = os.date("%X")
					
						-- set massage about enabled stepBack.
						local back = "Step back is enabled and time count down will start when player leave detecing area."

						-- when param STEP_BACK.enabled contains false we set back to false
						if not STEP_BACK.enabled then

							-- back will now contains disabled
							back = "Step back is disabled."

						end	

						-- display a message inside Rifbot.InformationBox
						printf("[" .. stepDate .. "] Successfully step due a player detected [" .. lastPlayer .. "] " .. back)
		        	
					end
					
				end	

			end	

		-- player is not found on detecting area.
		else		
			
			-- when we have enabled step back.
			if STEP_BACK.enabled then

				-- when time is valid.
				if os.time() - stepTime > (STEP_BACK.delay * 60) then

					-- load distance between safe position and your character.
					local distance = Self.DistanceFromPosition(STEP_BACK.pos[1], STEP_BACK.pos[2], STEP_BACK.pos[3])

		    		-- when our position is different than currentPos.
					if distance > 0 then

						-- load direction to step.
						local dir = Self.getDirectionFromPosition(STEP_BACK.pos[1], STEP_BACK.pos[2], STEP_BACK.pos[3], distance)
			
						-- step to this direction.
						Self.Step(dir)
						
						-- if we use on multiple chars
						if USE_ON_MULTIPLE_CHARS then
								
							-- say alana sio to kick char from house
							Self.Say("alana sio")
						
						end		
								
						-- wait some time to avoid over dashing.
						wait(500, 1000)

					-- our position is this same as we stay before
					else
						
						-- when stepDate is different than "" display message.
						if stepDate ~= "" then

							-- set message to console.
							printf("[" .. os.date("%X") .. "] Successfully return to position due a previus player detected: " .. lastPlayer)

							-- clear time var and stepDate
							stepTime = 0
							stepDate = ""

						end

					end
				
				-- invalid time to step back
				else			

					-- when time of printing is ok
					if os.time() - printfTime > 1 then

						-- display info about.
						printf("[" .. stepDate .. "] Successfully step due a player detected [" .. lastPlayer .. "] step back for " .. math.floor((STEP_BACK.delay * 60) - (os.time() - stepTime)) .. "s.")

						-- load current time
						printfTime = os.time()

					end	

					-- load distance between safe position and your character.
					local distance = Self.DistanceFromPosition(STEP_BACK.pos[1], STEP_BACK.pos[2], STEP_BACK.pos[3])

		    		-- when our position is this same as currentPos.
					if distance <= 0 then

						-- reset time and clear date
						stepTime = 0
						stepDate = ""

					end
						
				end
				
			-- step back is disabled	
			else		

				-- clear step date.
				stepDate = ""

			end
		
		end	

	-- we are offline	
	else		

		-- when reconnect contains true.
		if RECCONNECT then

			-- press enter key
			Rifbot.PressKey(13, 3000)

		end
			
	end
		
end) 
