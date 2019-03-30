--[[
    Script Name:        Open Backpack for MF
    Description:        Open next backpack if no mana fluid found.
    Author:             Ascer - example
]]

local MF_ID = 2874				-- id of mana fluid
local BACKPACK_ID = 2854		-- id of backpack with manafluids

-- DON'T EDIT BELOW

Module.New("Open Backpack for MF", function(mod)
	if not Container.FindItem(MF_ID) then
		local newCont = Container.FindItem(BACKPACK_ID) 
		if table.count(newCont) > 1 then
			Container.UseItem(newCont.index, newCont.slot, newCont.id, false) -- open new container in this same index
		end	
	end	
	mod:Delay(700, 1200)
end)