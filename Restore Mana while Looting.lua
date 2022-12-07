--[[
    Script Name: 		Restore Mana while Looting
    Description: 		When your character looting something from mobs then restoring mana will be delayed.
    					Designed mostly for Shadow Illusion mana runes.
    Author: 			Ascer - example
]]

local config = {
	item = 3157,										-- item id to restore mana
	mpperc = {ifLooting = 20, ifNoLooting = 70},		-- restore mp below this % if looting or if not looting
	minHpperc = 50,										-- don't restore mana if hpperc below this value.
	delay = 1000										-- miliceconds between item usage
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Restore Mana while Looting", function()
	if Self.isConnected() then
		if Self.HealthPercent() > config.minHpperc then
			local mp = Self.ManaPercent()
			local var = false
			if Looter.isLooting() then
				var = mp <= config.mpperc.ifLooting
			else
				var = mp <= config.mpperc.ifNoLooting
			end
			if var then
				Self.UseItemWithMe(config.item, config.delay)
			end	
		end	
	end	
end)