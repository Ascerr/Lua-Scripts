--[[
    Script Name:        Gold Changer
    Description:        Change gold coins -> platinum -> crystal coins
    Author:             Ascer - example
]]

local GOLD_ID = 3031											-- id of gold coin
local PLATINUM_ID = 3035										-- id of platinum coin
local USE_GOLD_CONVERTER_ITEM = {enabled = false, item = 7889, mode = "use"}	-- on some servers there is an item called Gold Converter, @enabled - true/false, @item - ID of gold converter, @mode - type of use: "with" - use item with gold, "use" - just use gold converter like food. 
local ONLY_IF_NO_MONSTER_ON_SCREEN = false						-- true/false when any monsters on screen don't convert gold to avoid exhausting.
local COLLECT_GOLD_TO_POUCH = false								-- use gold no matter of amount to collect it into gold pouch.

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
			if item.count == 100 or COLLECT_GOLD_TO_POUCH then
				if item.id == GOLD_ID or item.id == PLATINUM_ID then
					if USE_GOLD_CONVERTER_ITEM.enabled then
						local ammo = Self.Ammo()
						if ammo.id == USE_GOLD_CONVERTER_ITEM.item then
							if string.lower(USE_GOLD_CONVERTER_ITEM.mode) == "with" then
								Container.UseItemWithEquipmentOnContainer(SLOT_AMMO, ammo.id, cont.index, (j - 1), item.id, 0)
							else
								Self.UseItem(USE_GOLD_CONVERTER_ITEM.item, false, 0)
							end	
						else	
							local converter = Container.FindItem(USE_GOLD_CONVERTER_ITEM.item)
							if table.count(converter) > 1 then
								if string.lower(USE_GOLD_CONVERTER_ITEM.mode) == "with" then
									Container.UseItemWithContainer(converter.index, converter.slot, converter.id, cont.index, (j - 1), item.id, 0)
								else
									Self.UseItem(USE_GOLD_CONVERTER_ITEM.item, false, 0)
								end	
							end
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
