--[[
    Script Name:        Anty Paral
    Description:        Heal paralyse when hp is above.
    Author:             Ascer - example
]]

local PARAL = {spell = "exura", hpperc = 70, mana = 20}	 	-- spell -> what spell use to cure paral, hpperc -> cure paral if hpperc above, mana -> min mana to cast spell


-- DON'T EDIT BELOW THIS LINE

Module.New("Anty Paral", function ()
	
	-- when Connected.
	if Self.isConnected() then

		-- when paral
		if Self.isParalyzed() then

			-- when self hpperc above.
			if Self.HealthPercent() > PARAL.hpperc then

				-- when mana above
				if Self.Mana() > PARAL.mana then

					-- say spell
					Self.Say(PARAL.spell)

				end	

			end	

		end	

	end	

end)