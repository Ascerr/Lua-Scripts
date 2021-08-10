--[[
    Script Name:        Safe GFB
    Description:        Shoot gfb rune with monsters if many and single rune or spell when low amount.
    Author:             Ascer - example
]]

local AOE = {
	amount = 3, 												-- minimal monsters amount to shoot rune
	runeid = 3161, 												-- id of rune
	monsters = {"Rat", "Snake", "*"} 								-- type list of monsters, "*" to attack all
}

local SINGLE = {
	rune = {enabled = false, id = 3198},							-- shoot rune enabled true/false, rune id
	spell = {enabled = false, name = "exori con", mana = 30}	-- cast spell enabled true/false, spell name
}

local MIN_SELF_HPERC = 50										-- dont cast spell/rune when hpperc below 50%
local RUNE_DELAY = 2000											-- cast rune every (2000ms = 2s)
local SPELL_DELAY = 1000										-- cast spell every (1000ms = 1s)

					
-- DONT EDIT BELOW THIS LINE

local FRIENDS = Rifbot.FriendsList(true)
AOE.monsters = table.lower(AOE.monsters)

--> [Area where we can shoot rune on screen]
local runeMap = {{x=0,y=0}, {x=0,y=1}, {x=0,y=-1}, {x=1,y=0}, {x=-1,y=0}, {x=1,y=1}, {x=-1,y= 1}, {x=-1,y=-1}, {x=1,y=-1}, {x=2,y=0}, {x=-2,y=0}, {x=2,y=1}, {x=2,y=-1}, {x=-2,y=1}, {x=-2,y=-1}, {x=3,y=0}, {x=-3,y=0}, {x=3,y=1}, {x=3,y=-1}, {x=-3,y=1}, {x=-3,y=-1}}

--> [Rune attack area]
local aoePos = {{0,0}, {0,1}, {0,-1}, {1,0}, {-1,0}, {-1,1}, {-1,-1}, {1,-1}, {1,1}, {-2,-1}, {-2,0}, {-2,1}, {2,-1}, {2,0}, {2,1}, {0,-2}, {-1,-2}, {1,-2}, {-2,-2}, {2,-2}, {0,2}, {-1,2}, {1,2}, {-2,2}, {2,2}, {0,-3}, {-1,-3}, {1,3}, {0,3}, {-1,3}, {1,3}, {-3,0}, {-3,-1}, {-3,1}, {3,0}, {3,-1}, {3,1}} 


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		tableFindMapArg(tbl, arg)
--> Description: 	Search for table special arguments	
--> Params:			
-->					@tbl table to search
-->					@arg number, index name to search
-->
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function tableFindMapArg(tbl, arg) 
	for _, i in ipairs(tbl) do 
		if i.name == arg then 
			return true 
		end 
	end 
	return false 
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		table.match(pos, x, y, selfloc)
--> Description: 	check if position match results	
--> Params:			
-->					@pos table positions to search
-->					@x number position.x
-->					@y number position.y
-->					@selfloc table with self positions returned by Self.Position()
-->
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function table.match(pos, x, y, selfloc) 
	for v, k in ipairs(aoePos) do 
		if (x == (selfloc.x+pos.x+k[1]) and y == (selfloc.y+pos.y+k[2])) then 
			return true 
		end 
	end 
	return false 
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		tableReplace(tbl,arg) 
--> Description: 	Search for table special arguments	
--> Params:			
-->					@tbl table where we will replacing elements.
-->					@arg number, index name.
-->
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function tableReplace(tbl,arg) 
	for v, i in ipairs(tbl) do 
		if i.name == arg then 
			local lastCount = i.count table.remove(tbl,v) 
			table.insert(tbl,{name = arg, count = lastCount+1}) 
			return true 
		end 
	end 
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		safeGFB(monsters)
--> Description: 	Search best possible spot to shoot rune.
--> Params:			
-->					@monsters table with creatures
-->
--> Return: 		if failure return false else return table = {amount = ?, x = ?, y = ?}
----------------------------------------------------------------------------------------------------------------------------------------------------------
function safeGFB(monsters)

	-- load creatures
	local creatures = Creature.iCreatures(7, false)

	-- load self if.
	local selfid = Self.ID()

	-- check for players
	for i, creature in ipairs(creatures) do

		-- check if creature is player and is not friendly
		if Creature.isPlayer(creature) and creature.id ~= selfid and not table.find(FRIENDS, string.lower(creature.name)) and not Creature.isPartyMember(creature) and not Creature.isPartyLeader(creature) then

			-- return false we can't shoot there is player.
			return false

		end	

	end

	-- load self position
    local selfloc = Self.Position()

    -- create control table.
    local Cmd = {}

    -- inside loop check for monsters
    for i, creature in ipairs(creatures) do

    	-- when creature is monster and we find his name in table and hpperc is ok.
    	if Creature.isMonster(creature) and (table.find(monsters, string.lower(creature.name)) or table.find(monsters, "*")) and creature.hpperc <= 100 and creature.hpperc >= 1 then
	        
    		-- for range rune map.
	        for v = 1, #runeMap do
	            
	        	-- load signle pos
	            local pos = runeMap[v]
	            
	            -- when table match pos to createre x, y
	            if table.match(pos, creature.x, creature.y, selfloc) then
	                
	            	-- when no arg in table
	                if not tableFindMapArg(Cmd, v) then
	                    
	                	-- insert new pos
	                    table.insert(Cmd, {name = v, count = 1})
	                
	                else
	                    
	                    -- replace element in table
	                    tableReplace(Cmd, v)

	                end

	            end

	        end

	    end

    end

    -- store vars
    local var, use = 0, {0,0}

    -- in loop for all monsters
    for _, a in ipairs(Cmd) do
        
        -- check if var got lover count than current one.
        if var < a.count then
            
            -- update positions
            var,use = a.count, {runeMap[a.name].x, runeMap[a.name].y}
        
        end
    
    end
    
    -- return amount (monstes) and best location
    return {amount = var, x = selfloc.x+use[1], y = selfloc.y+use[2]}	

end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		singleAttack()
--> Description: 	Attack monster with rune or spell.
--> Params:			None
-->
--> Return: 		false or nill.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function singleAttack()

	-- when no enabled
	if not SINGLE.rune.enabled and not SINGLE.spell.enabled then return false end

	-- load self targetid.
	local target = Self.TargetID()

	-- when no attacking return.
	if target <= 0 then return false end

	-- load creature by target id
	local target = Creature.getCreatures(target)

	-- when failed to found creature return.
	if table.count(target) < 3 then return false end

	-- when creature is alive
	if target.hpperc > 0 then

		-- when enabled rune.
		if SINGLE.rune.enabled then

			-- shoot rune with target (2s) delay.
			Self.UseItemWithCreature(target, SINGLE.rune.id, RUNE_DELAY)

		-- when enable spell	
		elseif SINGLE.spell.enabled then	

			-- cast spell with target (1s) delay.
			Self.CastSpell(SINGLE.spell.name, SINGLE.spell.mana, SPELL_DELAY)

		end

	end		

end	


-- Mod running with 200ms loop.
Module.New("Safe GFB", function()

	-- when connected
	if Self.isConnected() and Self.HealthPercent() >= MIN_SELF_HPERC then

		-- load monsters
		local gfb, sd = safeGFB(AOE.monsters), false

		-- when monsters fund
		if gfb ~= false then
			
			-- when valid amount	
			if gfb.amount >= AOE.amount then
	        	
				-- use rune with ground (2s delay)
	        	Self.UseItemWithGround(AOE.runeid, gfb.x, gfb.y, Self.Position().z, RUNE_DELAY)

	        else	

	        	-- attack single
	        	singleAttack()

			end

		else
		
			-- attack single
	        singleAttack()	

		end	

	end	

end)
