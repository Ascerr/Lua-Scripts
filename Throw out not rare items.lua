--[[
    Script Name: 		Throw out not rare items
    Description: 		Collect all items by specific ID to one container, script will look on this items in bp and throw out this ones does not contains keywords in green message.
 
    Author: 			Ascer - example
]]


local config = {
	keyword = {"epic", "rare", "legendary", "gold coin", "platinum coin"},			-- catch this keywords, if not found item will be dropped under your character
	container_index = 0,															-- look on items only in this container index 0 = first opened
	max_look_slots = 3																-- looks only 3 first slots to reduce time for finding items. 
}

-- DON'T EDIT BELOW THIS LINE

local lookIndex, lastItemsAmount, canCheckProxy = 0, 0, false

function lookContainerItems()
	local items = Container.getItems(config.container_index)
	local itemsCount = table.count(items)
	if lastItemsAmount == itemsCount then
	 	lookIndex = 0
	 	return
	else  
		lastItemsAmount = 0
	end
	if (itemsCount-1) < lookIndex then 
		lookIndex = 0
		lastItemsAmount = itemsCount 
	end
	for i, item in ipairs(items) do
		if (i-1) == lookIndex then
			canCheckProxy = true
			return Self.LookItem("cont", config.container_index, (i-1), item.id)
		end		
	end	
end --> look container item for description

function dropSpecificSlot()
	local items = Container.getItems(config.container_index)
	for i, item in ipairs(items) do
		if (i-1) == lookIndex then
			local me = Self.Position()
			lookIndex = 0
			return Container.MoveItemToGround(config.container_index, (i-1), me.x, me.y, me.z, item.id, item.count, 0)
		end		
	end	
end	--> Drop common item to ground under your character

function isKeyword(msg)
	for i = 1, #config.keyword do
		if string.find(msg, config.keyword[i]) then
			return true
		end	
	end 
	return false	
end --> check if keyword found in look item message	

function proxyText(messages) 
	for i, msg in ipairs(messages) do 
		if canCheckProxy and string.find(msg.message, "You see") then
			if not isKeyword(msg.message) then
				dropSpecificSlot()
			end
			lookIndex = lookIndex + 1
			if lookIndex >= config.max_look_slots then
				lookIndex = 0
				lastItemsAmount = table.count(Container.getItems(config.container_index))
			end
			canCheckProxy = false	
		end		
	end 
end
Proxy.TextNew("proxyText") -->  register function to catch messages.

Module.New("Throw out not rare items", function()
	if Self.isConnected() then
		lookContainerItems()	
	end
end) --> -- Module run in loop.
