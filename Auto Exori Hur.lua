--[[
    Script Name: 		Auto Exori Hur
    Description: 		Cast exori hur if target > 0 and hpperc > 50% and mana points > 40
    Author: 			Ascer - example
]]

local SPELL = "exori hur"   -- spell to cast
local HPPERC = 50			-- don't cast if hp below %
local MANA = 40				-- minimal mana points to cast spell

Module.New("Auto Exori Hur", function (mod)
    local hp = Self.HealthPercent()
    local target = Self.TargetID()
    if hp > HPPERC and target > 0 and Self.Mana() >= MANA then
        Self.CastSpell(SPELL)
    end
    mod:Delay(300, 500)    
end)