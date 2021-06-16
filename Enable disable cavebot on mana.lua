--[[
    Script Name: 		Enable disable cavebot on mana
    Description: 		Disable cavebot on x% mana and enable on x% mana
    Author: 			Ascer - example
]]

local MPPERC = {on = 95, off = 30} 		-- enable cavebot when mana % above (ON) and disable when mana below (OFF)


-- DON'T EDIT BELOW THIS LINE


Module.New("Enable disable cavebot on mana", function (mod)
	
	-- when connected.
	if Self.isConnected() then

		-- load mana
		local mp = Self.ManaPercent()

		-- when mana below disable cavebot.
		if mp <= MPPERC.off then

			if Walker.isEnabled() then Walker.Enabled(false) end
			if Targeting.isEnabled() then Targeting.Enabled(false) end
			if Looter.isEnabled() then Looter.Enabled(false) end

		-- mana above enable cavebot
		elseif mp >= MPPERC.on then

			if not Walker.isEnabled() then Walker.Enabled(true) end
			if not Targeting.isEnabled() then Targeting.Enabled(true) end
			if not Looter.isEnabled() then Looter.Enabled(true) end

		end	

	end	

	-- execute every 500ms
	mod:Delay(500)

end)
