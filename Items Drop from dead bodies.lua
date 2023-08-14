--[[
    Script Name:        Items Drop from dead bodies
    Description:        Drop items under your character from specific containers names depend on cap.
    Author:             Ascer - example
]]

local config = {
	ids = {3031, 3607},	-- ids of items to drop
	cropse = {"The", "Demonic", "Dead", "Slain", "Dissolved", "Remains", "Elemental", "Split"}, -- names od dead cropses, add your if list no contains enough
	whenCapBelow = 50
}

-- DON'T EDIT BELOW THIS LINE

function getCropse(name)
    for _, element in ipairs(table.lower(config.cropse)) do
        if string.lower(name):find(element) then
            return true
        end
    end
    return false
end --> check if cropse name is valid

Module.New("Items Drop from dead bodies", function()
	if Self.isConnected() then
   		if Self.Capity() <= config.whenCapBelow then
	   		local containers = Container.getItems()
			for i, container in ipairs(containers) do
	    		local contInfo = Container.getInfo(container.index)
	    		if getCropse(contInfo.name) then
	        		local items = container.items
	        		for j, item in ipairs(items) do
						if table.find(config.ids, item.id) then
							local pos = Self.Position()
							return Container.MoveItemToGround(container.index, (j-1), pos.x, pos.y, pos.z, item.id, item.count, 0)	
						end	
					end       
	            end
	        end
	    end    
	end	
end)
