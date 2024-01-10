--[[
    Script Name:        Heal with eating food
    Description:        On some servers eating food give extra health and mana so lets use it.
    Author:             Ascer - example
]]

local config = {
	health = {perc = 80, food = {35348, 36090, 36004}},		-- heal health, percent, possible food
	mana = {perc = 50, food = {123}},						-- heal mana, precent, possible food	
	moduleDelay = {2000, 4000}								-- execute module (script loop) in random times between this delay.
}

-- DON'T EDIT BELOW
local useTime = 0

-- mod 200ms
Module.New("Heal with eating food", function(mod)
	if Self.isConnected() then
		if Self.HealthPercent() <= config.health.perc then
			if os.clock() - useTime >= 1 then
				local item = Container.FindItem(config.health.food)
				if table.count(item) > 0 then
					Container.UseItem(item.index, item.slot, item.id, false, 0)
					useTime = os.clock()
				end
			end		
		end
		if Self.ManaPercent() <= config.mana.perc then
			if os.clock() - useTime >= 1 then
				local item = Container.FindItem(config.mana.food)
				if table.count(item) > 0 then
					Container.UseItem(item.index, item.slot, item.id, false, 0)
					useTime = os.clock()
				end
			end		
		end		
	end
	mod:Delay(config.moduleDelay[1], config.moduleDelay[2])	
end)
