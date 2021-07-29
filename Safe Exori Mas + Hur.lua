--[[
    Script Name:        Safe Exori Mas + Hur
    Description:        Use exori mas only if not players around and specific amount of monsters else use exori hur.
    Author:             Ascer - example
]]

local EXORI = "exori mas"					-- name of spell to cast
local MANA = 250						-- min mana need to cast spell
local FRIENDS = {"Friend1", "Friend2"} 	-- list of friends we can use exori Capital letters like a Character Name
local MONSTERS_AMOUNT_TO_USE = 2		-- min monsters amount to cast spell
local DONT_CAST_WHEN_PLAYER_DIST = 4	-- don't use spell when player distance from self is equal or below this sqms.
local SELF_MIN_HPPERC = 50              -- don't cast spell if your character health percent is below this value

-- DON'T EDIT BELOW THIS LINE.

local aoePos = {{0,0}, {0,1}, {0,-1}, {1,0}, {-1,0}, {-1,1}, {-1,-1}, {1,-1}, {1,1}, {-2,-1}, {-2,0}, {-2,1}, {2,-1}, {2,0}, {2,1}, {0,-2}, {-1,-2}, {1,-2}, {0,2}, {-1,2}, {1,2}} 


local useSpellTime = 0


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       creatureInMasRange(creature, selfloc)
--> Description:    Check for creature is in exori mas range
--> Class:          None
--> Params:         
-->                 @creature table creature
-->                 @selfloc table self positions
--> Return:         boolean true or false.      
----------------------------------------------------------------------------------------------------------------------------------------------------------
function creatureInMasRange(creature, selfloc)
    for v, k in ipairs(aoePos) do 
        if (creature.x == (selfloc.x+k[1]) and creature.y == (selfloc.y+k[2])) then 
            return true 
        end 
    end 
    return false  
end 

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		ableToCastExori(friends, monstersAmount, playerRange)
--> Description: 	Check if character is able to cast exori spell in current situation.
--> Class: 			None
--> Params:			
-->					@friends table with friends, capital letters like a Character Name
-->					@monstersAmount number minimal monster amount around as to cast spell
-->					@playerRange number distance between player and you to don't cast spell. (equal or below)
--> Return: 		boolean true or false.		
----------------------------------------------------------------------------------------------------------------------------------------------------------
function ableToCastExori(friends, monstersAmount, playerRange)
	
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

        	-- if creature in mas range and hpperc is above 0.
        	if math.abs(c.z - pos.z) == 0 and c.hpperc > 0 and creatureInMasRange(c, pos) then

        		-- increase creature count
        		count = count + 1

                -- add creature to looter.
                Looter.AddCreature(c)

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


Module.New("Safe Exori Mas + Hur", function ()

	-- check for mana
	if Self.Mana() >= MANA and Self.HealthPercent() >= SELF_MIN_HPPERC then

		-- if time is ok.
		if os.time() - useSpellTime >= 1 then

			-- check if we can shoot exori.
			if ableToCastExori(FRIENDS, MONSTERS_AMOUNT_TO_USE, DONT_CAST_WHEN_PLAYER_DIST) then

				-- say spell
				Self.Say(EXORI)

				-- update time.
				useSpellTime = os.time()

            else    

                -- when self target id is > 0
                if Self.TargetID() > 0 then

                    -- say spell
                    Self.CastSpell("exori hur", 40, 2000)

                    -- update time.
                    --useSpellTime = os.time()

                end 

			end	

		end	

	end	

end)
