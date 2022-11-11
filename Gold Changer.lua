--[[
    Script Name:        Gold Changer
    Description:        Change gold coins -> platinum -> crystal coins
    Author:             Ascer - example
]]

local GOLD_ID = 3031											-- id of gold coin
local PLATINUM_ID = 3035										-- id of platinum coin
local USE_GOLD_CONVERTER_ITEM = {enabled = false, item = 5391}	-- on some servers there is an item called Gold Converter and its required to use it on stack.
local ONLY_IF_NO_MONSTER_ON_SCREEN = false						-- true/false when any monsters on screen don't convert gold to avoid exhausting.

-- DON'T EDIT BELOW

Module.New("Gold Changer", function()
	if ONLY_IF_NO_MONSTER_ON_SCREEN then
	 	if table.count(Creature.iMonsters(7, false)) > 0 then
	 		return false
	 	end
	end 		
	local items = Container.getItems(special)
	for i = 1, #items do
		local cont = items[i]
		local contItems = cont.items
		for j = 1, #contItems do
			local item = contItems[j]
			if item.count == 100 then
				if item.id == GOLD_ID or item.id == PLATINUM_ID then
					if USE_GOLD_CONVERTER_ITEM.enabled then
						local converter = Container.FindItem(USE_GOLD_CONVERTER_ITEM.item)
						if table.count(converter) > 2 then
							Container.UseItemWithContainer(converter.index, converter.slot, converter.id, cont.index, (j - 1), item.id, 0)
						end	
					else	
						Container.UseItem(cont.index, (j - 1), item.id, false)
					end	
					break
				end	
			end				
		end	
	end
	mod:Delay(500, 1200)
end)
