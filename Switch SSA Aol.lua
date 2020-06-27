--[[
    Script Name: 		Switch SSA Aol
    Description: 		Equip SSA when hp below 90% until hp drop below 50% then wear aol
    Author: 			Ascer - example
]]

local SSA = 3081                -- ID of stone skin amulet
local AOL = 3057                -- ID amulet of loss
local HPPERC = 50		        -- when hpperc below or equal wear aol, else wear ssa
local HPPERC_TO_WEAR_SSA = 90   -- wear ssa only if hpperc < 90%

Module.New("Switch SSA Aol", function ()
    local hp = Self.HealthPercent()
    local amulet = Self.Amulet()
    if hp <= HPPERC then
        if amulet.id ~= AOL then
            Self.EquipItem(SLOT_AMULET, AOL, 1)
        end
    else
        if hp <= HPPERC_TO_WEAR_SSA then
            if amulet.id ~= SSA then
                Self.EquipItem(SLOT_AMULET, SSA, 1)
            end
        end    
    end
end)
