--[[
    Script Name:        Safe Explo
    Description:        Use explosion rune only if not players around and specific amount of monsters.
    Author:             Ascer - example
]]

local RUNE = 3200					    -- rune id to shoot
local FRIENDS = {"Friend1", "Friend2"} 	-- list of friends we can use explo Capital letters like a Character Name
local MONSTERS_AMOUNT_TO_USE = 2		-- min monsters amount to cast spell
local DONT_CAST_WHEN_PLAYER_DIST = 2	-- don't use spell when player distance from self is equal or below this sqms.
local MANA = 20                         -- min mana need to shoot rune
local SELF_MIN_HPPERC = 70              -- don't shoot rune if your character health percent is below this value

-- DON'T EDIT BELOW THIS LINE.

local useRuneTime, range = 0, {{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		ableToShootRune(friends, monstersAmount, playerRange)
--> Description: 	Check if character is able to shoot explo rune in current situation.
--> Class: 			None
--> Params:			
-->					@friends table with friends, capital letters like a Character Name
-->					@monstersAmount number minimal monster amount around as to cast spell
-->					@playerRange number distance between player and you to don't cast spell. (equal or below)
--> Return: 		boolean true or false.		
----------------------------------------------------------------------------------------------------------------------------------------------------------
function ableToShootRune(friends, monstersAmount, playerRange)
	
	-- set creature count for 0.
	local count = 0

	-- load creatures 
	local creatures = Creature.iCreatures(playerRange, false)

	-- load self position.
	local pos = Self.Position()

	-- in loop for creatures.
	for i = 1, #creatures do
        
		-- load single creature.
        local c = creatures[i]
            
        -- if creature is player.
        if Creature.isPlayer(c) then

        	-- if not find friends in table
            if not table.find(FRIENDS, c.name) then

            	-- return false we can't use exori due player.
            	return false
                
            end

        -- if creature is monster count amount.   
        elseif Creature.isMonster(c) then

            -- when hpperc is above 0
            if c.hpperc > 0 then

                -- inside loop check for pos.
                for j = 1, #range do

                    -- when creature meet this requirements for pos
                    if c.x == (pos.x + range[j][1]) and c.y == (pos.y + range[j][2]) and c.z == pos.z then

                        -- increase creature count
                        count = count + 1

                        -- destroy loop
                        break

                    end    

                end    

        	end	

        end

    end

	-- if count is equal or above our target return true
    if count >= monstersAmount then

    	-- return true can use exori.
    	return true

    end

    -- return false we cant use exori due not enough monsters.
    return false	

end	


Module.New("Safe Explo", function ()

	-- check for mana
	if Self.Mana() >= MANA and Self.HealthPercent() >= SELF_MIN_HPPERC then

		-- if time is ok.
		if os.time() - useRuneTime >= 2 then

			-- check if we can shoot exori.
			if ableToShootRune(FRIENDS, MONSTERS_AMOUNT_TO_USE, DONT_CAST_WHEN_PLAYER_DIST) then

				-- shoot rune
                Self.UseItemWithMe(RUNE, 0)

				-- update time.
				useRuneTime = os.time()

			end	

		end	

	end	

end)
