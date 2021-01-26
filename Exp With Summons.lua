--[[
    Script Name: 		Exp With Summons
    Description: 		Pause walker when summon is out of screen.
    Author: 			Ascer - example
]]

local SUMMON_NAMES = {"Monk", "Orc Berserker"}		-- type here your summon names
local AMMOUNT = 1										-- type amount of summons to verify
local RANGE = 3											-- distance from summons to stop walker.
local MAX_WAIT_TIME = 60								-- maximum time in seconds to wait for summon

-- DON'T EDIT BELOW THIS LINE

-- convert table to lower names
SUMMON_NAMES = table.lower(SUMMON_NAMES)

local waitTime = 0

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getSummons(names, range, amount)
--> Description: 	Check for summons on screen.
--> Params:			
-->					@names - table, names of creatures to check
-->					@range - int, distance between you and creature to check
-->					@amount - int, amount of creatures to check.
--> Return: 		void nothing.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getSummons(names, range, amount)

	-- set count 0
	local count, dist = 0, 0

	-- read creatures on screen
	local creatures = Creature.iCreatures(7, false) 

	-- load self pos
	local selfpos = Self.Position() 

	-- for found creatures in loop
	for i = 1, #creatures do
	    
		-- load single creature
	    local c = creatures[i]

	    -- when creature has valid name
	    if table.find(names, string.lower(c.name)) then

	    	-- check for range
	    	local absx = math.abs(c.x - selfpos.x)
			local absy = math.abs(c.y - selfpos.y)
			dist = absx
			if absy > absx then
				dist = absy
			end

			-- when range is good.
			if dist <= range then 

		    	-- add count
		    	count = count + 1

		    	-- when count will good return true
		    	if count >= amount then 

		    		return true

		    	end	

		    end
		    
		end
		
	end

	-- return false not enough monsters.
	return false

end	
	

-- module run function in loop
Module.New("Exp With Summons", function ()
	
	-- when connected
	if Self.isConnected() then

		-- when no summons stop walker.
		if not getSummons(SUMMON_NAMES, RANGE, AMMOUNT) then

			-- when time is 0 set time.
			if waitTime <= 0 then 

				-- set time
				waitTime = os.clock()

				-- stop walker
				if Walker.isEnabled() then Walker.Enabled(false) end 

			else
				
				-- when max time reached 
				if os.clock() - waitTime > MAX_WAIT_TIME then	
					
					-- enable walker
					if not Walker.isEnabled() then Walker.Enabled(true) end

				else	

					-- stop walker
					if Walker.isEnabled() then Walker.Enabled(false) end

				end

			end

		else	

			-- enable walker
			if not Walker.isEnabled() then Walker.Enabled(true) end

			-- reset time
			waitTime = 0

		end	

	end
		
end)
