--[[
    Script Name:        Party Training
    Description:        Attack player if hp above x % and stop attack when below.
    Author:             Ascer - example
]]


local TRAINING_PLAYER = {
	name = "Player Name",
	hpperc = 50
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Party Training", function (mod)

	-- when we are connected
	if Self.isConnected() then
        
		-- read players on screen
        local players = Creature.iPlayers(7, false) 
        
        -- for found players in loop
        for i = 1, #players do
            
        	-- load single player
            local player = players[i]
            
            -- check for name
            if string.lower(TRAINING_PLAYER.name) == string.lower(player.name) then

            	-- when hpperc is above we can attack.
            	if player.hpperc > TRAINING_PLAYER.hpperc then

            		-- when target id is 0
            		if Self.TargetID() == 0 then

            			-- attack creature (without red square)	
            			Creature.Attack(player.id)

                		-- some wait
                		wait(500, 1000)

                		-- break loop
                		break

                	end

                -- player has low amount of hp	
                else	

                	-- check if is our target.
                	if Self.TargetID() == player.id then

                		-- stop attack.
                		Self.Stop()

                	end	

                end
                	
            end

        end

    end
	
	-- set module execution random (500, 800) 
    mod:Delay(500, 700) 

end)
