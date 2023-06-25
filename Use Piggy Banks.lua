--[[
    Script Name:        Use Piggy Banks
    Description:        Just use piggy bank and throw out trash.
    Author:             Ascer - example
]]

local config = {
	piggy_id = 2995,		-- id of new piggy bank item
	trash = {2996, 3492}	-- table of trash to throw out it under yourself
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Utrash door", function()
    if Self.isConnected() then
    	local trash = Container.FindItem(config.trash)
    	if table.count(trash) > 1 then
    		local pos = Self.Position()
    		Self.DropItem(pos.x, pos.y, pos.z, trash.id, trash.count, math.random(300, 500))
    	else	
    		local piggy = Container.FindItem(config.piggy_id)
    		if table.count(piggy) > 1 then
    			Container.UseItem(piggy.index, piggy.slot, piggy.id, false, 1000) -- use with delay 1000ms
    		end	
    	end 
    end	
end)