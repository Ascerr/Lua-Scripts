--[[
    Script Name: 		Drink fluids from dead monsters
    Description: 		Just if you drop fluid from monster character will use it with yourself.
    Author: 			Ascer - example
]]

local config = {
	id = 2874,	-- id of fluid
	cropse = {"The", "Demonic", "Dead", "Slain", "Dissolved", "Remains", "Elemental", "Split"}, -- names od dead cropses, add your if list no contains enough
	dontDrinkIfYourHppercBelow = 50 -- if your character hpperc will below don't drink fuild (maybe you need UH)
}

function getCropse(name)
    for _, element in ipairs(table.lower(config.cropse)) do
        if string.lower(name):find(element) then
            return true
        end
    end
    return false
end --> check if cropse name is valid

Module.New("Drink fluids from dead monsters", function()
	if Self.isConnected() then
   		local containers = Container.getItems()
		for i, container in ipairs(containers) do
    		local contInfo = Container.getInfo(container.index)
    		if getCropse(contInfo.name) then
        		local items = container.items
        		for j, item in ipairs(items) do
					if item.id == config.id and item.count ~= 0 then
						if Self.HealthPercent() >= config.dontDrinkIfYourHppercBelow then
							local pos = Self.Position()
							return Container.UseItemWithGround(container.index, (j-1), item.id, pos.x, pos.y, pos.z, 1000)
						end	
					end	
				end       
            end
        end
	end	
end)