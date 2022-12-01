--[[
    Script Name:        Alert if item count
    Description:        Play sound your character if item count is below/above x value.
    Author:             Ascer - example
]]


local config = {
	{id = 3031, count = 2, mod = "below"},				-- id = item id to check, count = amount of items, mod = we check for "above" or "below" count value
	--{id = 3031, count = 2, mod = "above"},	
}

-- DON'T EDIT BELOW THIS LINE.

function equipmentItemCount(id)
	local amount = 0
	for i = 0, 9 do
        local item = selfGetEquipmentSlot(i)
        if id == item.id then
        	if item.id == MANA_FLUID.id and MANA_FLUID.type == 0 then
				if item.count == MANA_FLUID.count then
					amount = amount + 1
				end	
			else
				amount = amount + item.count
			end
        end	
    end
    return amount	
end	--> get count of items in equipment by id.

-- Module to run functions in loop 200ms.
Module.New("Alert if item count", function ()
    if Self.isConnected() then
        for _, item in ipairs(config) do
        	local amount = Self.ItemCount(item.id) + equipmentItemCount(item.id)
        	local var = amount <= item.count
        	if item.mod == "above" then
        		var = amount >= item.count
        	end
        	if var then	
        		Rifbot.PlaySound("Default.mp3")
        		print("Item id: " .. item.id .. " is " .. item.mod .. " " .. item.count)
        	end		
        end	
    end        
end)

