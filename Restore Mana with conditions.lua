--[[
    Script Name: 		Restore Mana with conditions
    Description: 		Drink mana fluids/potions/runes depend on conditions like: walking, looting, monsters, hpperc
    Author: 			Ascer - example
]]

local config = {
	item = 3157,														-- item id to restore mana
	minHpperc = 50,														-- don't restore mana if hpperc below this value.
	mpperc = {
		ifConditionTrue = 20, 											-- when same condition meets requirements then character will restore mana on this level
		ifConditionFalse = 70, 											-- when all conditions don't meets requirements then character will restore mana on higher level.
		looting = false, 												-- when looting from monsters @enabled true/false
		walking = true, 												-- when walking @enabled true/false *works only when bot walks not you manually
		monsters = {enabled = true, amount = 1} 						-- when monsters on screen @enabled true/false, @amount - minimal mobs amount on screen
	},
	delay = 1000														-- miliseconds between item usage
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Restore Mana with conditions", function()
	if Self.isConnected() then
		if Self.HealthPercent() > config.minHpperc then
			local value = config.mpperc.ifConditionFalse
			if config.mpperc.looting and Looter.isLooting() then value = config.mpperc.ifConditionTrue end
			if config.mpperc.walking and Self.isWalking() then value = config.mpperc.ifConditionTrue end
			if config.mpperc.monsters.enabled and table.count(Creature.iMonsters(7, false)) >= config.mpperc.monsters.amount then value = config.mpperc.ifConditionTrue end 
			if Self.ManaPercent() <= value then
				Self.UseItemWithMe(config.item, config.delay)
			end
		end	
	end	
end)