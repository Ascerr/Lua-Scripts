--[[
    Script Name: 		Enable Cavebot when low Soul
    Description: 		Turn on cavebot when low soul points
    Author: 			Ascer - example
]]

local ENABLE_TRAINER_WHEN_SOUL = 20 -- when soul points equal or below this value enable cavebot


-- DONT EDIT BELOW THIS LINE

Module.New("Enable Cavebot when low Soul", function (mod)
	
	-- when self connected.
	if Self.isConnected() then

		--load soul points
		local soul = Self.Soul()

		-- when soul points are below x enable.
		if soul <= ENABLE_TRAINER_WHEN_SOUL then

			if not Walker.isEnabled() then Walker.Enabled(true) end
			if not Targeting.isEnabled() then Targeting.Enabled(true) end
			if not Looter.isEnabled() then Looter.Enabled(true) end

		end	
	end	

	-- mod delay
	mod:Delay(1000, 1500)

end)

