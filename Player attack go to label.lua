--[[
    Script Name: 		Player attack go to label
    Description: 		When player attack you go to label in walker.
    Author: 			Ascer - example
]]

local config = {
	label = "safe place",			-- label name we go when player attack us. 
	canReadCheckAgainForMins = 10	-- how many minutes to enable re-checking for player attacking when we already go to label.
}

-- DONT EDIT BELOW THIS LINE.

local changedLabel, changeTime = false, 0


-- module to run function
Module.New("Player attack go to label", function ()

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
        
	    -- in loop for creatures.
	    for i, player in ipairs(Creature.iPlayers(7, false)) do

	    	-- when player attack.
	    	if player.attack > 0 then

	    		-- show message
	    		print(player.name .. " attacked you!")

	    		-- when we don't changed label then
	    		if not changedLabel then

	    			-- go to label
	    			Walker.Goto(config.label)

	    			-- set.
	    			changedLabel = true
	    			changeTime = os.clock()

	    		end	

	    		-- destroy lop
	    		break

	    	end	
	    	
	    end

	end

end)
