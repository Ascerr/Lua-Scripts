--[[
    Script Name: 		Go House Make Rune and Back
    Description: 		When current mana level go to house make rune and back with alana sio. 
    Author: 			Ascer - example
]]

local HOUSE_POS = {x = 32346, y = 32219, z = 5} -- Position to go

local SPELL = {
	name = "adura vita",		-- spell name
	mana = 100					-- min mana to cast spell
}

local BACK_ON_FEET = {
	enabled = false,					-- true/false back on feet not using alana sio
	pos = {x = 32346, y = 32220, z = 5} -- back position
}

-- DON'T EDIT BELOW THIS LINE

local spellTime, stepTime = 0, 0


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		delayedStep(dir, delay)
--> Description: 	Step with delay	
--> Params:			
-->
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
-->
-->					@texrt string message to say on default channel.
-->					@delay number miliseconds between say.
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function delayedSay(text, delay)
	if os.clock() - spellTime > (delay / 1000) then
		Self.Say(text)
		spellTime = os.clock()
	end	
end	

-- module to run function inside loop
Module.New("Go House Make Rune and Back", function ()
	
	-- when connected
	if Self.isConnected() then

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

end)
