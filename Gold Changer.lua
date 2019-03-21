--[[
    Script Name:        Gold Changer
    Description:        Change gold coins -> platinum -> crystal coins
    Author:             Ascer - example
]]

local GOLD_ID = 3031
local PLATINUM_ID = 3035

-- DON'T EDIT BELOW

Module.New("Gold Changer", function()
	local items = Container.getItems(special)
	for i = 1, #items do
		local cont = items[i]
		local contItems = cont.items
		for j = 1, #contItems do
			local item = contItems[j]
			if item.count == 100 then
				if item.id == GOLD_ID or item.id == PLATINUM_ID then
					Container.UseItem(cont.index, (j - 1), item.id, false)
					break
				end	
			end				
		end	
	end
	mod:Delay(500, 1200)
end)