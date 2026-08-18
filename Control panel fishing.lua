--[[
    Script Name:        Control panel fishing
    Description:        On off fishing depend on cap or amount fish in container/eq.
    Author:             Ascer - example
]]

local FISH_ID = 3567                                    -- id of fish
local AMOUNT = {start = 0, finish = 20, cap = 10}       -- start fishing when amount, stop fising when amount, stop fishing if cap below

Module.New("Control panel fishing", function(mod)
    if Self.isConnected() then
        local fish = Self.ItemCount(FISH_ID)
        local weapon = Self.Weapon()
        local shield = Self.Shield()
        local ammo = Self.Ammo()
        if weapon.id == FISH_ID then fish = fish + weapon.count end
        if shield.id == FISH_ID then fish = fish + shield.count end
        if ammo.id == FISH_ID then fish = fish + ammo.count end
        local cap = Self.Cap()
        if cap <= AMOUNT.cap or fish >= AMOUNT.finish then
            Rifbot.setCheckboxState("Tools", "AutoFishing", false)
        else 
            if fish <= AMOUNT.start then
                Rifbot.setCheckboxState("Tools", "AutoFishing", true)
            end    
        end    
    end
    mod:Delay(500, 800)    
end)