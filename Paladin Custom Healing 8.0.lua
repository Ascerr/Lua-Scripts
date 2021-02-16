--[[
    Script Name: 		Paladin Custom Healing 8.0
    Description: 		Auto mana fluid and heal with exura vita, when low mana use uhs.
    Author: 			Ascer - example
]]


local AUTO_MF_UP_TO = 80		-- drink mana fluid up to 80%
local HEAL = {spell = "exura vita", hpperc = 80, mana = 160} -- cast exura vita if hpperc is below 80% and mana above 160
local UH_ID = 3160
local MF_ID = 2874

-- DON'T EDIT BELOW THIS LINE


-- loop module.
Module.New("Paladin Custom Healing 8.0", function ()
	
	-- when connected.
	if Self.isConnected() then
		
		-- load mana, manapercent and healthpercent
		local mana = Self.Mana()
		local mpperc = Self.ManaPercent()
		local hpperc = Self.HealthPercent()

		-- when low hp.
		if hpperc <= HEAL.hpperc then

			-- when no mana to cast spell
			if mana < HEAL.mana then

				-- use uhs every 1000ms
				Self.UseItemWithMe(UH_ID, 1000)

			else	

				-- cast spell.
				Self.Say(HEAL.spell)

			end

		else		
				
			-- when mana percent below.
			if mpperc < AUTO_MF_UP_TO then

				Self.UseItemWithMe(MF_ID, 1000)

			end	

		end	

	end

end)
