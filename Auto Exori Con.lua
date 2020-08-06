--[[
    Script Name: 		Auto Exori Con
    Description: 		Cast exori con if target > 0 and hpperc > 50%
    Author: 			Ascer - example
]]

local SPELL = "exori vis"   -- spell to cast
local HPPERC = 50			-- don't cast if hp below %

Module.New("Auto Exori Con", function (mod)
    local hp = Self.HealthPercent()
    local target = Self.TargetID()
    if hp > HPPERC and target > 0 then
        Self.CastSpell(SPELL)
    end
    mod:Delay(300, 500)    
end)
