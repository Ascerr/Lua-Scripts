--[[
    Script Name:        UH + IH healing + mana rune
    Description:       	Use exeta con when monsters and hp > x%
    Author:             Ascer - example
]]


local config = {
	light = {hpperc = 90, itemid = 3152},		-- light healing with IH (Intense Healing Rune) when hpperc <= 90% and above 70%
	heavy = {hpperc = 70, itemid = 3160},		-- heavy healing when UH (Ultimate Healing Rune) hpperc < 70 %
	mana = {mpperc = 70, itemid = 3157},		-- heal mana when hp is > 90% and mana below 70%
	delay = 1000								-- delay to use rune 1000ms
}

--  DON'T EDIT BELOW THIS LINE

local castTime = 0


function useOnMe(id)
	if os.clock() - castTime < (config.delay/1000) then return false end
	Self.UseItemWithMe(id, 0)
	castTime = os.clock() 
end	


Module.New("UH + IH healing + mana rune", function ()
	
	-- when connected.
	if Self.isConnected() then

		-- load hp, mama
		local mpperc = Self.ManaPercent()
		local hpperc = Self.HealthPercent()

		-- when low heal.
		if hpperc < config.heavy.hpperc then

			-- use heavy rune
			useOnMe(config.heavy.itemid)

		else	

			-- when hpperc is below light
			if hpperc < config.light.hpperc then

				-- use light rune
				useOnMe(config.light.itemid)

			else

				-- when mana is below
				if mpperc < config.mana.mpperc then

					-- use mana rune
					useOnMe(config.mana.itemid)

				end	

			end	

		end	

	end

end)