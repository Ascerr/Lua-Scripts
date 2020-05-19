--[[
    Script Name:        Open Backpack for Blanks
    Description:        Open next backpack if no blank runes found.

    Remarks:			You need to have blanks like this: backpack-> backpack (with 19 blanks and backpack)
    Author:             Ascer - example
]]

local BLANK_RUNE_ID = 2260		-- id of blank rune // new id: 3147
local BACKPACK_ID = 2004		-- id of backpack with blank runes

-- DON'T EDIT BELOW

Module.New("Open Backpack for Blanks", function(mod)
	local blank = Container.FindItem(BLANK_RUNE_ID)
	if not blank then
		local newCont = Container.FindItem(BACKPACK_ID) 
		if table.count(newCont) > 1 then
			Container.UseItem(newCont.index, newCont.slot, newCont.id, false) -- open new container in this same index
		end	
	end	
	mod:Delay(700, 1200)
end)