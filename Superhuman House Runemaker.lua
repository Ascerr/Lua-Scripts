--[[
    Script Name: 		Superhuman House Runemaker
    
    Description: 		Advanced script to house runemaking (otclient compatible only)

    					1. If current mana level go house make rune and back on feet or alana sio.
    					2. Check for players on screen or multifloor and hide. Back for 5 min example.
    					3. When gets dmg hide to house too. Both 2 & 3 has use friends.txt safe list.
    					4. When appear fire on screen expand back time for WHEN_PLAYER_HIDE.back.delay.
    					5. Pickup full bp of balnk runes and throw out full bp of created runes (Main backpack opener).
    					6. Go to house for eating food at time to time.
	
	Update: 2022-09-06	Added option: SPELL.only_outside to allow make runes outside house when some servers don't allow cast spells in protection zone.

    Required:			Rifbot 2.00 or higher. 
    					
    Author: 			Ascer - example 
]]

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> CONFIG SECTION: start - read it carefully becaue it's important!
----------------------------------------------------------------------------------------------------------------------------------------------------------

local HOUSE_POS = {x = 32334, y = 32234, z = 7} 	-- Position inside house
local BACK_POS = {x = 32335, y = 32234, z = 7} 		-- Position outside house

local SPELL = {
	name = "adori gran flam", 						-- spell name
	mana = 125,										-- min mana to cast spell
	go_house = false,								-- true/false step to house before making rune to avoid pz lock.
	only_outside = true,							-- true/false make rune only outside house (on some server you can't make it inside pz zone)
	change_dir = {enabled = false, dir = 2}			-- enabled - true/false, dir - direction 0-3. Change character look direction after back to pos near door.
}

local BACK_ON_FEET = {
	enabled = false, 								-- true/false back on feet not using alana sio
}

local WHEN_PLAYER_HIDE = {
	enabled = true, 								-- true/false hide to house when player appear (ignore safe list from friends.txt)
	multifloor = false, 							-- true/false check player for above and below floors.
	back = {enabled = true, delay = 5} 				-- back true/false, delay time in minutes to back after.
}

local WHEN_DMG_TAKEN_HIDE = {
	enabled = true, 								-- true/false hide to house if character get dmg (ignore safe list from friends.txt)
	keywords = {"You lose"}, 						-- keywords to catch from proxy message
	back = {enabled = false, delay = 10}				-- back true/false go out of house after attacked by player, separated delay for go out.
}

local WHEN_FIRE_NEAR_DOOR_WAIT = {
	enabled = true, 								-- true/false don't go out if near door where stay your character are fields (checking for pos BACK_POS)
	fields = {2118, 2119, 2120, 2121, 2122, 2123} 	-- fields id to check (ofc if someone trash field there is no way to check it)
}

local PICKUP_BLANK_DROP_BP_RUNES = {
	enabled = false, 								-- enabled true/false
	blank_backpack_id = 2868, 						-- id of backpack with blank runes
	blank_rune_id = 3147, 							-- blank rune id
	blank_pos = {x = 32368, y = 31765, z = 6}, 		-- position of backpacks with blank runes (should be 1sqm from you)
	finish_pos = {x = 32368, y = 31764, z = 6} 		-- position to drop finished backpack.
}

local EAT_FOOD_FROM_GROUND = {
	enabled = false, 								-- enabled true/false eat food from house ground
	food = {3578, 3725}, 							-- food ids
	delay = {7, 12}, 								-- delay time to eat food in minutes math.random(a, b)
	pos = {x = 32367, y = 31765, z = 6} 			-- position where lay food on ground.
}

local ANTI_PUSH = {                                 
    enabled = false,                                 -- enabled true/false if your character will stay on any position from pos table will go to safe pos.
    pos = {                                         -- positions table just add this around your house door (outside).
        {x = 32367, y = 31767, z = 6},
        {x = 32367, y = 31768, z = 6},
        {x = 32368, y = 31768, z = 6},
        {x = 32369, y = 31768, z = 6},
        {x = 32369, y = 31767, z = 6}
    }
}

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> CONFIG SECTION: end
----------------------------------------------------------------------------------------------------------------------------------------------------------



-- DON'T EDIT BELOW THIS LINE

local spellTime, stepTime, friends, backTime, logTime, lastPlayer, isPlayer, pickupBlanks, foodTime, foodDelay, eatFood = 0, 0, Rifbot.FriendsList(true), 0, 0, "", false, false, 0, 0, false


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
--> Function:		getPlayer()
--> Description: 	Get player on screen.
-->					
--> Return: 		table with creature or false when failed.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPlayer()

	-- inside loop for all found creatures on multiple floors do:
	for i, player in pairs(Creature.iPlayers(7, WHEN_PLAYER_HIDE.multifloor)) do

		-- when we can not find a friends and creature is player:
		if not table.find(friends, string.lower(player.name)) then

			-- return table with creature
			return player

	    end

	end

	-- return false noone player found.
	return false

end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		eatFoodFromGround()
--> Description: 	Eat food from house ground position
-->					
--> Return: 		nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function eatFoodFromGround()

	-- when disabled return
	if not EAT_FOOD_FROM_GROUND.enabled then return end

	-- when time is wrong return
	if os.clock() - foodTime < foodDelay * 60 then return end

	-- set param eatFood = true
	eatFood = true

	-- when current position is far than 1 sqm from eating pos.
	if Self.DistanceFromPosition(EAT_FOOD_FROM_GROUND.pos.x, EAT_FOOD_FROM_GROUND.pos.y, EAT_FOOD_FROM_GROUND.pos.z) > 1 then

		-- go there
		Self.WalkTo(EAT_FOOD_FROM_GROUND.pos.x, EAT_FOOD_FROM_GROUND.pos.y, EAT_FOOD_FROM_GROUND.pos.z)

	else	

		-- set amount to use.
		local tries = math.random(7, 10)

		-- inside loop use food.
		for i = 1, tries do

			-- load map with food
			local map = Map.GetTopMoveItem(EAT_FOOD_FROM_GROUND.pos.x, EAT_FOOD_FROM_GROUND.pos.y, EAT_FOOD_FROM_GROUND.pos.z)

			-- if food id is different than our
			if not table.find(EAT_FOOD_FROM_GROUND.food, map.id) then

				-- load self pos
				selfpos = Self.Position()

				-- maybe trashed? move items to our feet
				Map.MoveItem(EAT_FOOD_FROM_GROUND.pos.x, EAT_FOOD_FROM_GROUND.pos.y, EAT_FOOD_FROM_GROUND.pos.z, selfpos.x, selfpos.y, selfpos.z, map.id, map.count, 0)

				-- wait some time
				wait(400, 700)

			else	

				-- use ground id (food eat)
				Map.UseItem(EAT_FOOD_FROM_GROUND.pos.x, EAT_FOOD_FROM_GROUND.pos.y, EAT_FOOD_FROM_GROUND.pos.z, map.id, 1, 0)

				-- wait some time
				wait(800, 1200)

			end	

		end	

		-- update food time
		foodTime = os.clock()

		-- set new random food delay.
		foodDelay = math.random(EAT_FOOD_FROM_GROUND.delay[1], EAT_FOOD_FROM_GROUND.delay[2])

		-- disable eat food
		eatFood = false

	end	

end	


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		pickupBlanksDropRunes()
--> Description: 	Drop finished backpacks to house and grab bps blanks.
-->					
--> Return: 		nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function pickupBlanksDropRunes()
	
	-- if no enabled return
	if not PICKUP_BLANK_DROP_BP_RUNES.enabled then return end

	-- when no main backpack open
	if table.count(Container.getInfo(0)) < 2 then

		-- when some other containers are opened
		if Container.Amount() > 0 then

			-- close all containers
			Container.CloseAll()

			-- wait some time
			wait(700, 1000)

		else

			-- open main backpack
			Self.OpenMainBackpack()

			-- wait some time
			wait(700, 1000)

		end

	else		

		-- when no second backpack opened
		if table.count(Container.getInfo(1)) < 2 then

			-- when amount of container is above 1
			if Container.Amount() > 1 then

				-- close all containers
				Container.CloseAll()

				-- wait some time
				wait(700, 1000)

			else	

				-- if we have blank backpack inside main
				if table.count(Container.FindItem(PICKUP_BLANK_DROP_BP_RUNES.blank_backpack_id, 0)) > 2 then

					-- disable pickup blanks
					pickupBlanks = false

					-- open backpack.
					Container.Open(0, PICKUP_BLANK_DROP_BP_RUNES.blank_backpack_id, true, math.random(500, 700))

				else

					-- enable pickup blanks
					pickupBlanks = true

					-- when distance from take blanks pos is far than 1sqm walk to.
					if Self.DistanceFromPosition(PICKUP_BLANK_DROP_BP_RUNES.blank_pos.x, PICKUP_BLANK_DROP_BP_RUNES.blank_pos.y, PICKUP_BLANK_DROP_BP_RUNES.blank_pos.z) > 1 then

						-- go there
						Self.WalkTo(PICKUP_BLANK_DROP_BP_RUNES.blank_pos.x, PICKUP_BLANK_DROP_BP_RUNES.blank_pos.y, PICKUP_BLANK_DROP_BP_RUNES.blank_pos.z)

					else	

						-- pickup one backpack from ground.
						Self.PickupItem(PICKUP_BLANK_DROP_BP_RUNES.blank_pos.x, PICKUP_BLANK_DROP_BP_RUNES.blank_pos.y, PICKUP_BLANK_DROP_BP_RUNES.blank_pos.z, PICKUP_BLANK_DROP_BP_RUNES.blank_backpack_id, 1)

						-- wait some time
						wait(700, 1000)

					end	

				end	

			end

		else		

			-- load count of blank runes inside backpacks 
			local count = Self.ItemCount(PICKUP_BLANK_DROP_BP_RUNES.blank_rune_id, 1)

			-- load count self weapon slot.
			local weapon = Self.Weapon()

			-- when weapon is this same as blank id.
			if weapon.id == PICKUP_BLANK_DROP_BP_RUNES.blank_rune_id then

				-- add count
				count = count + 1

			end	

			-- when count jest below or equal 0
			if count <= 0 then

				-- drop backpack to position.
				Self.DropItem(PICKUP_BLANK_DROP_BP_RUNES.finish_pos.x, PICKUP_BLANK_DROP_BP_RUNES.finish_pos.y, PICKUP_BLANK_DROP_BP_RUNES.finish_pos.z, PICKUP_BLANK_DROP_BP_RUNES.blank_backpack_id, 1, math.random(700, 1000))

			end	

		end	

	end	

end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		antipush()
--> Description: 	When character reach any od ANTI_PUSH.pos then will go to safe place.
-->					
--> Return: 		nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function antipush()

	-- when no enabled then return
	if not ANTI_PUSH.enabled then return end

	-- load self position
	local selfpos = Self.Position()

	-- inside table check if we are on danger position
	for i, danger in ipairs(ANTI_PUSH.pos) do

		-- check for pos.
		if selfpos.x == danger.x and selfpos.y == danger.y and selfpos.z == danger.z then

			-- set param that is player and attacked as.
            isPlayer = true

            -- set param for info logs
			lastPlayer = "<character was pushed>"

			-- break loop
			break

		end	

	end	

end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		changeDir()
--> Description: 	When character stay near house door then will keep direction you set.
-->					
--> Return: 		nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function changeDir()

	-- when no enabled then return
	if not SPELL.change_dir.enabled then return end

	-- when distance from back pos is diff return
	if Self.DistanceFromPosition(BACK_POS.x, BACK_POS.y, BACK_POS.z) ~= 0 then return end

	-- check for dir
	if Self.Direction() ~= SPELL.change_dir.dir then

		-- change dir.
		Self.Turn(SPELL.change_dir.dir)

	end	

end	

-- proxy function to catch dmg taken signals
function proxy(messages) 
	
	-- when hide if dmg is disabled return
	if not WHEN_DMG_TAKEN_HIDE.enabled then return false end

	-- inside loop for all messages
	for i, msg in ipairs(messages) do 
		
		-- when message mode is 16 (error message)
		if msg.mode == 16 then

			-- in loop for key words
		    for i = 1, #WHEN_DMG_TAKEN_HIDE.keywords do

		        -- load single key
		        local key = WHEN_DMG_TAKEN_HIDE.keywords[i]

		        -- check if string is inside proxy
		        if string.instr(msg.message, key) then

		            -- in loop check if string not contains our friends.
		            for j = 1, #friends do

		                -- load single friend.
		                local friend = friends[j]

		                -- check if attacking our friend destroy loop.
		                if string.instr(msg.message, "attack by " .. friend) then break end   

		            end

		            -- set param that is player and attacked as.
		            isPlayer = true

		            -- set param for info logs
					lastPlayer = "<dmg taken>"

					-- update back time.
					backTime = os.clock()

		            -- show log.
		            delayedLog(msg.message, 0)

		        end
		        
		    end

		end	

	end

end 

-- register proxy function
Proxy.TextNew("proxy")	


-- module to run function inside loop
Module.New("Go House Make Rune and Back", function ()
	
	-- when connected
	if Self.isConnected() then

		-- set param player to false
		local player = false	

		-- check for move position.
		antipush()

		-- control backpacks
		pickupBlanksDropRunes()

		-- eat food
		eatFoodFromGround()

		-- check for dir change
		changeDir()

		-- when player on screen
		if WHEN_PLAYER_HIDE.enabled then

			-- load player checking.
			player = getPlayer()

		end

		-- when player detected
		if player or isPlayer then

			-- load distance
			local dist = Self.DistanceFromPosition(HOUSE_POS.x, HOUSE_POS.y, HOUSE_POS.z)

			-- check if we are in house.
			if dist > 0 and not pickupBlanks and not eatFood then
				
		        -- go to house.
		        Self.WalkTo(HOUSE_POS.x, HOUSE_POS.y, HOUSE_POS.z)

		        -- show info in information box
		        printf("walking to house..")

		        -- set param for player
		        isPlayer = true

		    else
		    	
		    	if lastPlayer ~= "<dmg taken>" then
		    	
			    	-- update time we spent in house
			    	backTime = os.clock()

			    	-- when player 
			    	if player then
				    	
				    	-- update logs
				    	delayedLog("Go to safe place due player: " .. player.name, 2000) 

				    	-- store last name
				    	lastPlayer = player.name

				    end

				else    

					if WHEN_DMG_TAKEN_HIDE.enabled and WHEN_DMG_TAKEN_HIDE.back.enabled then

						-- load difference time
			    		local diff = (os.clock() - backTime)

			    		-- set delay
			    		local delayBack = WHEN_DMG_TAKEN_HIDE.back.delay * 60

			    		-- when delay is near disable timer re-new if player enter.
			    		if delayBack - diff <= 5 then

			    			lastPlayer = ""

			    		end 


					end	

				end    	

		    	-- disable player
		    	isPlayer = false  

		    end 

		else	

			-- load mana
			local mp = Self.Mana()

			-- when mana is above.
			if not SPELL.only_outside and mp >= SPELL.mana and not pickupBlanks and not eatFood then

				-- when don't step into house
				if not SPELL.go_house then

					-- say spell every 2.5s
					delayedSay(SPELL.name, 2500)

				else
					
					-- load distance
					local dist = Self.DistanceFromPosition(HOUSE_POS.x, HOUSE_POS.y, HOUSE_POS.z)

					-- check if we are in house.
					if dist == 0 then

						-- say spell every 2.5s
						delayedSay(SPELL.name, 2500)

					else
			
			            -- step to safe pos
			            Self.WalkTo(HOUSE_POS.x, HOUSE_POS.y, HOUSE_POS.z)

			        end 

			    end

			else       
			
		    	-- set able to back
		    	local ableBack = true

		    	-- when return is enabeld after time
		    	if (WHEN_PLAYER_HIDE.enabled and WHEN_PLAYER_HIDE.back.enabled) or (WHEN_DMG_TAKEN_HIDE.enabled and WHEN_DMG_TAKEN_HIDE.back.enabled) then

		    		-- load difference time
		    		local diff = (os.clock() - backTime)

		    		-- set delay
		    		local delayBack = WHEN_PLAYER_HIDE.back.delay * 60

		    		-- when dmg taken change delay.
		    		if lastPlayer == "<dmg taken>" and WHEN_DMG_TAKEN_HIDE.enabled and WHEN_DMG_TAKEN_HIDE.back.enabled then 

		    			delayBack = WHEN_DMG_TAKEN_HIDE.back.delay * 60

		    		end	

		    		-- when diff is not enough
		    		if diff < delayBack then

		    			-- set able back on false
		    			ableBack = false

		    			-- show info about back
		    			delayedLog("Step due: " .. lastPlayer .. ", back for " .. math.floor(delayBack - diff) .. "s..", 1000)

						-- load distance
						local dist = Self.DistanceFromPosition(BACK_POS.x, BACK_POS.y, BACK_POS.z)

		    			-- when we back manually to pos reset time.
		    			if dist == 0 then

		    				-- reset time
		    				backTime = 0

		    				-- enable back
		    				ableBack = true

		    				-- reset last player
		    				lastPlayer = ""

		    				-- set message
		    				delayedLog("You back manually on BACK_POS reset time.", 0)

		    			end	

		    		end	

		    	end

		    	-- when checking for fields near house
		    	if WHEN_FIRE_NEAR_DOOR_WAIT.enabled then
		    		
		    		-- load map with items
		    		local map = Map.GetItems(BACK_POS.x, BACK_POS.y, BACK_POS.z)

		    		-- inside loop check for items
		    		for i, item in ipairs(map) do

		    			-- when item.id is in table disable back
		    			if table.find(WHEN_FIRE_NEAR_DOOR_WAIT.fields, item.id) then

		    				-- disable back
		    				ableBack = false

		    				-- reset time
		    				backTime = os.clock()

		    				-- set param to field	
							lastPlayer = "<field>"

		    				-- show log.
		    				delayedLog("deteced field near house: " .. item.id, 1000)

		    				-- break loop
		    				break

		    			end	

		    		end	

		    	end	

		    	-- when able to back and don't pickup blanks and don't eat food
		    	if ableBack and not pickupBlanks and not eatFood then

		    		-- check dist between return pos.
			    	local dist = Self.DistanceFromPosition(BACK_POS.x, BACK_POS.y, BACK_POS.z)

			    	-- reset last palyer
					lastPlayer = ""

			    	-- when back on feet is enabled
			    	if BACK_ON_FEET.enabled then

			    		-- when dist is diff than 0
			    		if dist ~= 0 then

				            -- step to safe pos
				            Self.WalkTo(BACK_POS.x, BACK_POS.y, BACK_POS.z)

				        end    

			    	else	

						-- when we have no more mana for cast spell and dist = 0 then back with alana sio.  
						if dist ~= 0 then

							-- say alana sio every 3s
							delayedSay("alana sio \"" .. Self.Name(), 1000)

						end 

					end	

				end	

			end

			if SPELL.only_outside and mp >= SPELL.mana and not pickupBlanks and not eatFood then

				-- say spell every 2.5s
				delayedSay(SPELL.name, 2500)

			end	

		end		

	end	

end)
