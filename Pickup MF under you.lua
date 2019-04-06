--[[
    Script Name:        Pickup MF under you
    Description:        Pickup mana fluid under your character to container.index 0 slot 0
    Author:             Ascer - example
]]

local MF_ID = 2874     -- set 2006 for old tibia

-- DON'T EDIT BELOW


Module.New("Pickup MF under you", function (mod)
	local pos = Self.Position()
	Self.PickupItem(pos.x, pos.y, pos.z, 2874, 1, 0, 0, 100)
	mod:Delay(200, 400)
end)