--[[
    Script Name: 		Create food
    Description: 		Cast food creation spell when no food inside bp.
    Author: 			Ascer - example
]]

local FOODS = {3725, 3607}							-- ids of food to check
local CREATE_WHEN_AMOUNT = 1						-- cast spell when amount of food <= this amount
local SPELL = {name = "exevo pan", mana = 40}		-- spell to create food

-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		isFood()
--> Description: 	Check for food in containers
--> Params:			None

--> Return: 		number food quantity.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function isFood()
	local items, amount = Container.getItems(), 0
	for i, cont in pairs(items) do
		local contItems = cont.items
		for j, item in pairs(contItems) do
			if table.find(FOODS, item.id) then
				amount = amount + item.count
			end		
		end
	end
	return amount
end	

-- module run in loop
Module.New("Create food", function (mod)
	if Self.isConnected() then
		if isFood() <= CREATE_WHEN_AMOUNT then
			Self.CastSpell(SPELL.name, SPELL.mana, 2000)
		end	
	end		
	mod:Delay(1000, 1500)		
end)
