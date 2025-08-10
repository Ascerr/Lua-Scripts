--[[
    Script Name:        Heal with eating food
    Description:        On some servers eating food give extra health and mana so lets use it.
    Author:             Ascer - example
]]

local config = {
	health = {perc = 80, food = {35348, 36090, 36004}},		-- heal health, percent, possible food
	mana = {perc = 50, food = {123}},						-- heal mana, precent, possible food	
	moduleDelay = {500, 1000},								-- execute module (script loop) in random times between this delay.
	eatDelay = 3000											-- delay on first usage to avoid instant eating
}

-- DON'T EDIT BELOW
local useTime, eatTime = 0, 0

-- mod 200ms
Module.New("Heal with eating food", function(mod)
	if Self.isConnected() then
		if Self.HealthPercent() <= config.health.perc then
			if eatTime == 0 then eatTime = os.clock() end	
			if os.clock() - useTime >= 1 and os.clock() - eatTime >= config.eatDelay/1000 then
				local item = Container.FindItem(config.health.food)
				if table.count(item) > 0 then
					Container.UseItem(item.index, item.slot, item.id, false, 0)
					useTime = os.clock()
				end
			end		
		elseif Self.ManaPercent() <= config.mana.perc then
			if eatTime == 0 then eatTime = os.clock() end
			if os.clock() - useTime >= 1 and os.clock() - eatTime >= config.eatDelay/1000 then
				local item = Container.FindItem(config.mana.food)
				if table.count(item) > 0 then
					Container.UseItem(item.index, item.slot, item.id, false, 0)
					useTime = os.clock()
				end
			end
		else
			eatTime = 0			
		end		
	end
	mod:Delay(config.moduleDelay[1], config.moduleDelay[2])	
end)
