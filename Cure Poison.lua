--[[
    Script Name:        Cure Poison
    Description:        Cast exana pox when your character under poison cond.
    Author:             Ascer - example
]]

local config = {
	spell = "exana pox",		-- name of spell to cast
	minHealth = 50,				-- don't cast if self hpperc below.
	ifNoMonsters = false,		-- true/false when monsters don't cast
}

Module.New("Cure Poison", function ()
    if Self.isConnected() then
	    if Self.isPoisioned() then
	    	if Self.HealthPercent() >= config.minHealth then    
	        	if config.ifNoMonsters and table.count(Creature.iMonsters(7, false)) > 0 then return end
	        	Self.CastSpell(config.spell, 30)
	        end	
	    end
	end        
end)
