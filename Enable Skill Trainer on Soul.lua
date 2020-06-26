--[[
    Script Name: 		Enable Skill Trainer on Soul
    Description: 		Turn on/off skill trainer depent on soul
    Author: 			Ascer - example
]]

local ENABLE_TRAINER_WHEN_SOUL = 80 -- when soul points equal or below this value enable trainer
local OFFSET_SOUL = 0x4F8 -- offset to addr in mem Kasteria soul points

-- DONT EDIT BELOW THIS LINE

Module.New("Enable Skill Trainer on Soul", function (mod)
	
	-- when self connected.
	if Self.isConnected() then

		-- load self creature.
		local me = Creature.getCreatures(Self.ID())

		-- when creature has found.
		if table.count(me) > 1 then

			-- read memory for soul
			local soul = Rifbot.MemoryRead(me.addr + OFFSET_SOUL, "double")

			-- when soul points are below x enable.
			if tonumber(soul) <= ENABLE_TRAINER_WHEN_SOUL then

				-- enable skill trainer
				Rifbot.setCheckboxState("skill trainer", "enabled", true)

			else
				
				-- disable trainer
				Rifbot.setCheckboxState("skill trainer", "enabled", false)

			end	

		end	

	end
	
	-- mod delay
	mod:Delay(1000, 1500)

end)

