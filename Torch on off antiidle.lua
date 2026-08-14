--[[
    Script Name:        Torch on off antiidle
    Description:        Turn on and turn off torch at time to time to avoid automatic disconnect after 15min without activity.
    Author:             Ascer - example
]]

local TORCH = {2921, 2923, 2925}           -- {ONLY} a lit torch id
local USE_TIME = {5, 15}                   -- use every random minutes

-- DON'T EDIT BELOW THIS LINE

local useTime, useDelay = 0, 1

Module.New("Torch on off antiidle", function()
	if Self.isConnected() then
        if os.clock() - useTime >= (useDelay*60) then
            local ammo = Self.Ammo()
            Self.UseItemFromEquipment(SLOT_AMMO, 500)
            wait(800, 1500)
            Self.UseItemFromEquipment(SLOT_AMMO, 500)
            wait(800)
            useTime = os.clock()
            useDelay = math.random(USE_TIME[1], USE_TIME[2])
        else    
            local ammo = Self.Ammo()
            if table.find(TORCH, ammo.id) then
                Self.UseItemFromEquipment(SLOT_AMMO, 500) -- prevent torch stuck on lit
            end    
        end    
    end    
end)