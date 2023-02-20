--[[
    Script Name: 		Back Bp For Runes + Throw Empty Bp
    Description: 		Character will check for runes amount inside specific container index, when no runes then it back container and throw out backpack (should be empty)
    Required:			Runes in backpack opened like this: backpack = {19 runes + backpack = {19 runes + backpack = {..}}} AND opened it to last container.
    Author: 			Ascer - example
]]

local config = {
	runes = {
		{index = 1, id = 3160},				-- @index of container (0 = first opened, 1 = second), @id of runes to search 
		{index = 2, id = 3155}				-- other runes backpack..
	},
	disable_cavebot_for_while = true		-- true/false disable cavebot module when opening new backpack.
}	


-- DON'T EDIT BELOW THIS LINE

local action = {state = 0, index = 0, id = 0, time = 0}

-- mod run function inside loop
Module.New("Back Bp For Runes + Throw Empty Bp", function()
	for _, rune in ipairs(config.runes) do
		if action.state == 0 then
			if Container.isOpen(rune.index) and Self.ItemCount(rune.id, rune.index) <= 0 then
				local cont = Container.getInfo(rune.index)
				if table.count(cont) < 1 then return end
				if config.disable_cavebot_for_while then
					if Cavebot.isEnabled() then
						Cavebot.Enabled(false)
					end
				end		
				Container.Back(rune.index, 0)
				action = {state = 1, index = rune.index, id = rune.id, bp = cont.id, time = os.clock()}
			end		
		else	
			if action.state == 1 then
		 		if Self.ItemCount(action.id, action.index) <= 0 then
					if os.clock() - action.time > 3 then
						action.state = 0
					end	
				else
					action.state = 2
				end
			elseif action.state == 2 then
				local item = Container.FindItem(action.bp, action.index)
				if table.count(item) > 1 then
					local pos = Self.Position()
					Container.MoveItemToGround(action.index, item.slot, pos.x, pos.y, pos.z, item.id, 1, 0)
					action.state = 3
				end
			elseif action.state == 3 then
				if config.disable_cavebot_for_while then
					if not Cavebot.isEnabled() then
						Cavebot.Enabled(true)
					else	
						action.state = 0
					end
				else		
					action.state = 0
				end		
			end
		end	
	end	
end)