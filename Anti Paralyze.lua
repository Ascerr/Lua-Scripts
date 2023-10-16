--[[
    Script Name:        Anti Paralyze
    Description:        Heal paralyze when hp is above.
    Author:             Ascer - example
]]

local config = {
	light = {spell = "exura", hpperc = 100, mana = 25},			-- light cure, when you have full hp or little below like 30%, it's possible to use haste spell here
	heavy = {spell = "exura vita", hpperc = 65, mana = 160},	-- heavy cure, when your hpperc is low and better cure para with restoring hpperc too.
	ifNoMonsters = false,										-- true/false heal only when no monsters on screen
	useLightSpellWhenNoManaForHeavy = false						-- true/false when you don't have enough mana for cure para with heavy spell use light
}


-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMonsters()
--> Description: 	Read creatures for monsters on screen.
--> Params:			None
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonsters()
	for i, mob in pairs(Creature.iMonsters(7, false)) do
		return true
	end
	return false
end

Module.New("Anti Paralyze", function ()
	if Self.isConnected() then
		if Self.isParalyzed() then
			if config.ifNoMonsters and getMonsters() then return end
			local selfHpperc = Self.HealthPercent()
			local mp = Self.Mana()
			if selfHpperc <= config.heavy.hpperc then
				if mp >= config.heavy.mana then
					Self.Say(config.heavy.spell)
				else
					if config.useLightSpellWhenNoManaForHeavy then
						if mp >= config.light.mana then
							Self.Say(config.light.spell)
						end	 
					end	
				end	
			else
				if mp >= config.light.mana then
					Self.Say(config.light.spell)
				end	 
			end	
		end	
	end	
end)
