--[[
    Script Name: 		Charge Empty Scroll
    Description: 		Will charge empty scroll with specific item.
    Author: 			Ascer - example
]]

local config = {
	empty_scrolls = {5108, 5112},	-- IDs of empty scrolls can be one or more. Separate it by comma.
	charge_item = 5129				-- ID of item to recharge scroll.
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Charge Empty Scroll", function (mod)
	local scroll = Container.FindItem(config.empty_scrolls)
	if table.count(scroll) > 1 then
		local charge = Container.FindItem(config.charge_item)
		if table.count(charge) > 1 then
			Container.UseItemWithContainer(charge.index, charge.slot, charge.id, scroll.index, scroll.slot, scroll.id, 0)
		end	
	end	
	mod:Delay(1000)
end)
