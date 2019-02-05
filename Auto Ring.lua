--[[
    Script Name: 		Auto Ring
    Description: 		Equip ring when ring_slot is empty e.g. refil life ring to speed up mana regen
    Author: 			Ascer - example
]]

local RINGID = 3052                  -- life ring (not used)
local MAIN_DELAY = {700, 2000}       -- random delay reading loop. You can increase it for personal usage.

-- DON'T EDIT BELOW THIS LINE

Module.New("Auto Ring", function (mod)
    if Self.isConnected() then -- check for connection to game
        local slot = Self.Ring()
        if slot.id <= 0 then
            Self.EquipItem(SLOT_RING, RINGID, 1)
        end
    end
    mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2])        
end)
