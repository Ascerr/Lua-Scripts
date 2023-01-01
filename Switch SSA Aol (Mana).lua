--[[
    Script Name: 		Switch SSA Aol (Mana)
    Description: 		Equip SSA when mpperc below 90% until mperc drop below 30% then wear aol
    Author: 			Ascer - example
]]

local SSA = 3081                -- ID of stone skin amulet
local AOL = 3057                -- ID amulet of loss
local MPPERC = 30		        -- when mpperc below or equal wear aol, else wear ssa
local MPPERC_TO_WEAR_SSA = 95   -- wear ssa only if mpperc < 90%

Module.New("Switch SSA Aol (Mana)", function ()
    local mp = Self.ManaPercent()
    local amulet = Self.Amulet()
    if mp <= MPPERC or mp > MPPERC_TO_WEAR_SSA then
        if amulet.id ~= AOL then
            Self.EquipItem(SLOT_AMULET, AOL, 1, 0) -- delay 0
        end
    else
        if mp <= MPPERC_TO_WEAR_SSA then
            if amulet.id ~= SSA then
                Self.EquipItem(SLOT_AMULET, SSA, 1, 0) -- delay 0
            end
        end    
    end
end)
