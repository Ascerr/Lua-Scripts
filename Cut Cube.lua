--[[
    Script Name:        Cut Cube
    Description:        Use machete or other weapon id with possible table of items ids (different states on pre statue)
    Author:             Ascer - example
]]

local config = {
	cube = {7441,7442,7443,7445},	-- cube ids one or many.
	machete = 3308	-- machete id need to be inside container
}

-- loop module
Module.New("Cut Cube", function()
	local cube = Container.FindItem(config.cube)	
	local machete = Container.FindItem(config.machete)
	if table.count(cube) > 1 and table.count(machete) then
		Container.UseItemWithContainer(machete.index, machete.slot, machete.id, cube.index, cube.slot, cube.id, 1500)
	end	
end)