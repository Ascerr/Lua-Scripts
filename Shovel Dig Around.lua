--[[
    Script Name:        Shovel Dig Around
    Description:        Use Shovel around your character
    Author:             Ascer - example
]]

local SHOVEL = 3457

-- DONT'T EDIT BELOW THIS LINE

Module.New("Shovel Dig Around", function (mod)
	
	local pos = Self.Position()
	local randX = math.random(-1, 1)
	local randY = math.random(-1, 1)
	
	-- use shovel on random position near me.
	Self.UseItemWithGround(SHOVEL, pos.x+randX, pos.y+randY, pos.z)
	
	mod:Delay(1000, 1200) -- set random delay
end)