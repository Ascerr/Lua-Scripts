--[[
    Script Name: 		Count Strange Mana Regen
    Description: 		Count avg mana regeneration per tick (results in Information Box).
    Author: 			Ascer - example
]]


-- DON'T EDIT BELOW THIS LINE
local lastMana, tick, tickClock, tickTime, tickCount, tickMana = Self.Mana(), 0, os.clock(), 0, 0, 0

-- mod to run function in loop 200ms
Module.New("Count Strange Mana Regen", function ()

	-- when connected
	if Self.isConnected() then

		-- load self mana.
		local mp = Self.Mana()

		-- when last mana is diff than currnet
		if mp > lastMana then

			-- calculate diff of mana regen
			local diff = (os.clock() - tickClock) * 1000

			-- update tickTime
			tickClock = os.clock()

			-- increase tickTime
			tickTime = tickTime + diff

			-- increase tickCount
			tickCount = tickCount + 1

			-- calculate tickMana
			tickMana = tickMana + (mp - lastMana)

		end	

		-- update lastMana
		lastMana = mp

	end	

	printf("Avg tick mana regen is " .. math.floor(tickMana / tickCount) .. " mana per " .. math.floor(tickTime / tickCount) / 1000 .. " sec." )

end)
