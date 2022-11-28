--[[
    Script Name:        Heal with eating food
    Description:        On some servers eating food give extra health so lets use it.
    Author:             Ascer - example
]]

local config = {
	hpperc = 80,							-- when self health percent below this value eat food.
	food = {35348, 36090, 36004},			-- possible foods to eat
	delay = 3000							-- eating delay
}

-- DON'T EDIT BELOW
local useTime = 0

-- mod 200ms
Module.New("Heal with eating food", function()
	if Self.isConnected() then
		if Self.HealthPercent() <= config.hpperc then
			if os.clock() - useTime >= config.delay/1000 then
				local item = Container.FindItem(config.food)
				if table.count(item) > 0 then
					Container.UseItem(item.index, item.slot, item.id, false, 0)
					useTime = os.clock()
				end
			end		
		end	
	end	
end)
