--[[
    Script Name: 		Utito Tempo If Monster
    Description: 		Cast spell if monster on screen
    Author: 			Ascer - example
]]

local SPELL = {
	name = "Utito Tempo",		-- spell name
	mana = 290,					-- min mana to cast spell
	amount = 1,					-- min monsters amount to cast spell
	delay = 10					-- cast every seconds
}


-- DON'T EDIT BELOW THIS LINE

local spellTime = 0

Module.New("Utito Tempo If Monster", function (mod)
	
	-- when connected
	if Self.isConnected() then

		-- check for delay
		if os.clock() - spellTime > SPELL.delay then

			-- load monsters
			local mobs = Creature.iMonsters(7, false)

			-- when monsters
			if table.count(mobs) >= SPELL.amount then

				-- check for mana
				if Self.Mana() >= SPELL.mana then

					-- cast spell.
					Self.Say(SPELL.name)

					-- update delay
					spellTime = os.clock()

				end	

			end

		end	

	end	

	-- module delay
	mod:Delay(500)

end)
