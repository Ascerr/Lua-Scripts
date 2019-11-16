--[[
    Script Name: 		Random UH
    Description: 		Use RUNE_ID with your character when hp drop below, simulate manual player.
    Author: 			Ascer - example
]]

local RUNE_ID = 3160 	-- id of item to use
local HPPERC_BELOW = 50	-- if hpperc is below this value. (randomized upper 1-5%)
local RANDOM_SLOW_MOTION = {500, 1000} -- wait this random time when health drop before use uh. (simulate click uh in bp and on yourself time)

-- DONT'T EDIT BELOW THIS LINE 

-- storage of value.
randomWait, startTime, hppercBelow = 0, 0, HPPERC_BELOW

Module.New("Random UH", function ()
    
    -- load self health percent
    local hpperc = Self.HealthPercent()

    -- when health percent drop below value and startTime is 0, we set config.
    if hpperc <= hppercBelow and startTime == 0 then

    	-- set random time to wait and startTime.
    	randomWait = math.random(RANDOM_SLOW_MOTION[1], RANDOM_SLOW_MOTION[2])/1000
    	startTime = os.clock()

    end
    
    -- when time is already set (our hp was below value)
    if startTime ~= 0 then

    	-- when time to use rune already come.
    	if (os.clock() - startTime) >= randomWait then

    		-- check for hpperc. If this is still below value use rune.
    		if hpperc <= hppercBelow then

    			-- use rune with me to heal from dmg.
    			Self.UseItemWithMe(RUNE_ID)

    			-- rest values.
    			randomWait, startTime, hppercBelow = 0, 0, HPPERC_BELOW + math.random(1, 5)

    		else		

    			-- if our hpperc is above value so if it's only above 7% use uh is this case.	
    			if (hpperc - hppercBelow) <= 7 then

    				-- use rune with me to heal from dmg.
    				Self.UseItemWithMe(RUNE_ID)

    				-- rest values.
    				randomWait, startTime, hppercBelow = 0, 0, HPPERC_BELOW + math.random(1, 5)

    			else
    			
    				-- Our hpperc look like someone heal us or we do it manually, rest values.
    				randomWait, startTime, hppercBelow = 0, 0, HPPERC_BELOW + math.random(1, 5)

    			end
    			
    		end
    		
    	end
    
    end

end)
