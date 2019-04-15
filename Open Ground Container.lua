--[[
    Script Name:        Open Ground Container
    Description:        Will open ground container after relogin to game as first index.
    Author:             Ascer - example
]]

local CONTAINER = {
	id = 2853,			-- id of ground container
	x  = 32093, 		-- posx
	y  = 32216, 		-- posy
	z  = 7				-- posz
}


-- DONT'T EDIT BELOW THIS LINE

var = true

Module.New("No Soul Cast Spell", function ()
	if Self.isConnected() then
		if var then
			wait(1000, 1700)
			Map.UseItem(CONTAINER.x, CONTAINER.y, CONTAINER.z, CONTAINER.id)
			var = false
		end
	else
		var = true
	end			
end)