--[[
    Script Name: 		Exp With Summons
    Description: 		Pause walker when summon is out of screen. 
    					Also heal monsters with rune but you never summon this same monsters you exp on. 
    Author: 			Ascer - example
]]

local SUMMON_NAMES = {"Monk", "Orc Berserker"}			-- type here your summon names
local AMMOUNT = 1										-- type amount of summons to verify
local RANGE = 3											-- distance from summons to stop walker.
local MAX_WAIT_TIME = 60								-- maximum time in seconds to wait for summon

local HEAL_SUMMONS = { 									-- heal summons with uh/ih:
	enabled = true, 									-- true/false
	runeid = 2273, 										-- id to heal (2273 is uh)
	mob_hpperc = 50, 									-- heal when mob hp below
	your_hpperc = 50,									-- don't heal mob when yout hpperc is below
	heal_delay = 1500									-- heal monster every miliseconds (1000ms = 1s)
}

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
--> Return: 		boolean true or false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getSummons(names, range, amount)

	-- set count 0
	local count, dist, tbl = 0, 0, {}

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

		    	-- add table with monster
		    	table.insert(tbl, c)

		    	-- when count will good tbl
		    	if count >= amount then 

		    		return tbl

		    	end	

		    end
		    
		end
		
	end

	-- return table monsters.
	return tbl

end	
	

-- module run function in loop
Module.New("Exp With Summons", function ()
	
	-- when connected
	if Self.isConnected() then

		-- load summons
		local summons = getSummons(SUMMON_NAMES, RANGE, AMMOUNT)

		-- do only if hpperc is above 
		if HEAL_SUMMONS.enabled and Self.HealthPercent() >= HEAL_SUMMONS.your_hpperc then

			-- in loop check monster hp.
			for i = 1, #summons do
		    
				-- load single creature
		    	local c = summons[i]

		    	-- when hpperc is below then heal
		    	if c.hpperc <= HEAL_SUMMONS.mob_hpperc then

		    		-- heal monster.
		    		Self.UseItemWithCreature(c, HEAL_SUMMONS.runeid, heal_delay)

		    		-- break loop
		    		break

		    	end	

		    end	

		end		    

		-- when no summons stop walker.
		if table.count(summons) < AMMOUNT then

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
