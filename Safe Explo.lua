--[[
    Script Name:        Safe Explo
    Description:        Shoot explo rune with monsters if many or into target and single rune or spell when low amount or players.
    Author:             Ascer - example
]]

local AOE = {
	amount = 2, 												-- minimal monsters amount to shoot rune
	runeid = 3200, 												-- id of rune
	monsters = {"Rat", "Snake", "*"}, 							-- type list of monsters, "*" to attack all
	shoot_only_with_target = false								-- true/false shoot only with target 	
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
local runeMap = {{x =-1, y =-1}, {x =-1, y =0}, {x =-1, y =1}, {x =-1, y =2}, {x =0, y =-2}, {x =0, y =-1}, {x =0, y =0}, {x =0, y =1}, {x =0, y =2}, {x =1, y =-2}, {x =1, y =-1}, {x =1, y =0}, {x =1, y =1}, {x =1, y =2}, {x =2, y =-2}, {x =2, y =-1}, {x =-5, y =-2}, {x =-5, y =-1}, {x =-5, y =0}, {x =-5, y =1}, {x =-5, y =2}, {x =-4, y =-2}, {x =-4, y =-1}, {x =-4, y =0}, {x =-4, y =1}, {x =-4, y =2}, {x =-3, y =-2}, {x =-3, y =-1}, {x =-3, y =0}, {x =-3, y =1}, {x =-3, y =2}, {x =-2, y =-2}, {x =-2, y =-1}, {x =-2, y =0}, {x =-2, y =1}, {x =-2, y =2}, {x =-1, y =-2}, {x =2, y =0}, {x =2, y =1}, {x =2, y =2}, {x =3, y =-2}, {x =3, y =-1}, {x =3, y =0}, {x =3, y =1}, {x =3, y =2}, {x =4, y =-2}, {x =4, y =-1}, {x =4, y =0}, {x =4, y =1}, {x =4, y =2}, {x =5, y =-2}, {x =5, y =-1}, {x =5, y =0}, {x =5, y =1}, {x =5, y =2}, {x=-5, y=-3}, {x=-4, y=-3}, {x=-3, y=-3}, {x=-2, y=-3}, {x=-1, y=-3}, {x=0, y=-3}, {x=1, y=-3}, {x=2, y=-3}, {x=3, y=-3}, {x=4, y=-3}, {x=5, y=-3}, {x=-5, y=3}, {x=-4, y=3}, {x=-3, y=3}, {x=-2, y=3}, {x=-1, y=3}, {x=0, y=3}, {x=1, y=3}, {x=2, y=3}, {x=3, y=3}, {x=4, y=3}, {x=5, y=3}}

--> [Rune attack area]
local aoePos = {{0, 0}, {-1, 0}, {1, 0}, {0, -1}, {0, 1}} 


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
--> Function:		safeExplo(monsters)
--> Description: 	Search best possible spot to shoot rune.
--> Params:			
-->					@monsters table with creatures
-->
--> Return: 		if failure return false else return table = {amount = ?, x = ?, y = ?}
----------------------------------------------------------------------------------------------------------------------------------------------------------
function safeExplo(monsters)

	-- if enabled with target.
	if AOE.shoot_only_with_target then
		return shootExploOnlyWithTarget()
	end	

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

function shootExploOnlyWithTarget()
	local target = Self.TargetID()
	local pos = Self.Position()
	local selfid = Self.ID()
	if target <= 0 then return false end
	local creatures = Creature.getCreatures()
	local targetCreature = -1
	for _, c in ipairs(creatures) do
		if c.id == target and Creature.isMonster(c) and c.z == pos.z then
			targetCreature = c
			break
		end	
	end
	if table.count(targetCreature) < 2 then return false end 
	for _, c in ipairs(creatures) do
		if Creature.isPlayer(c) and c.z == pos.z and c.id ~= selfid then
			if math.abs(c.x - targetCreature.x) <= 2 or math.abs(c.y - targetCreature.y) <= 2 then return false end
		end	
	end
	Self.UseItemWithCreature(targetCreature, AOE.runeid, RUNE_DELAY)
	return true 	
end	 --> shoot rune only with target.

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
Module.New("Safe Explo", function()

	-- when connected
	if Self.isConnected() and Self.HealthPercent() >= MIN_SELF_HPERC then

		-- load monsters
		local explo, sd = safeExplo(AOE.monsters), false

		-- when monsters fund
		if explo ~= false then
			
			if not AOE.shoot_only_with_target then

				-- when valid amount	
				if explo.amount >= AOE.amount then
		        	
					-- use rune with ground (2s delay)
		        	Self.UseItemWithGround(AOE.runeid, explo.x, explo.y, Self.Position().z, RUNE_DELAY)

		        else	

		        	-- attack single
		        	singleAttack()

				end

			end	

		else
		
			-- attack single
	        singleAttack()	

		end	

	end	

end)
