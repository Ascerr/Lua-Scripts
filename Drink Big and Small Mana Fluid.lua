--[[
    Script Name:        Drink Big and Small Mana Fluid
    Description:        Restore your character mana using normal mana fluid if high % of mana and big mana fluid if low % of mana.
    Author:             Ascer - example
]]

local SMALL_MANA_FLUID = {mpperc = 70, id = 2006}			-- ID of standard mana fluid
local BIG_MANA_FULUID = {mpperc = 50, id = 5595}        	-- ID of big mana fluid  
local MIN_HEAL_PERCENT = {hpperc = 50, enabled = false}		-- don't drink mana if hpperc is <= 50%, @enabled = true/false 
local ONLY_VISIBLE_FLUIDS = false							-- true/false allow use small fluid even if low mana level when big fluid not found
local DELAY = {1000, 1500}     								-- delay for fluid is default 1000ms we set a little bit higher.

-- DONT'T EDIT BELOW THIS LINE 

local mainDelay, mainTime = 0, 0

Module.New("Drink Big and Small Mana Fluid", function ()
    if Self.isConnected() then
	    local mpperc = Self.ManaPercent()
	    local hpperc = Self.HealthPercent()
	    if ((MIN_HEAL_PERCENT.enabled and hpperc > MIN_HEAL_PERCENT.hpperc) or not MIN_HEAL_PERCENT.enabled) then
		    if mpperc <= BIG_MANA_FULUID.mpperc then
		    	if ONLY_VISIBLE_FLUIDS then
		    		local mf = Container.FindItem(BIG_MANA_FULUID.id)
		    		if table.count(mf) <= 0 then
						return Self.UseItemWithMe(SMALL_MANA_FLUID.id, math.random(DELAY[1], DELAY[2]))
		    		end	
		    	end	
		    	Self.UseItemWithMe(BIG_MANA_FULUID.id, math.random(DELAY[1], DELAY[2]))	
		    else	
		    	if mpperc <= SMALL_MANA_FLUID.mpperc then
		    		Self.UseItemWithMe(SMALL_MANA_FLUID.id, math.random(DELAY[1], DELAY[2]))
		    	end	
		    end
		end    
	end                
end)