--[[
    Script Name: 		Off targeting for while if first monster 
    Description: 		Default targeting will be off but when see monster from list it will enable it back with delay to prevent fast bot attack.
    Author: 			Ascer - example
]]

local config = {
	delay = 500,					-- starting delay before attack first monster 500ms = 0.5s 
	range = 6,						-- search monsters in range (7 deafult full screen)
	list = {"Rat", "Hydra", "Behemoth", "Demon", "Serpent Spawn", "Dwarf Guard"}	-- list monsters to search.
}


-- DON'T EDIT BELOW THIS LINE

local startTime = 0

config.list = table.lower(config.list)

function getMonsters()
	for i, mob in pairs(Creature.iMonsters(config.range, false)) do
		if table.find(config.list, string.lower(mob.name)) then
			return true
		end	
	end		
	return false
end	

Module.New("Off targeting for while if first monster ", function ()
	if Self.isConnected() then
		if not getMonsters() then 
			if Targeting.isEnabled() then 
				Targeting.Enabled(false)
				startTime = 0 
			end
		else
			if startTime <= 0 then 
				startTime = os.clock()
			else	
				if os.clock() - startTime >= config.delay/1000 then
					if not Targeting.isEnabled() then Targeting.Enabled(true) end
				end	
			end	
		end
	end	
end)
