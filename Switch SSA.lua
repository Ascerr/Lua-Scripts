--[[
    Script Name: 		Switch SSA
    Description: 		Equip SSA when mana or hp is below 40% and dequip if above.
    Author: 			Ascer - example
]]

local AMULET_ID = 3081 		     -- id amulet to wear (default ssa 3081)
local TYPE = "mana"              -- which value to read "mana" or "hp"
local VALUE = 75			     -- when mpperc or hpperc <= this percent then wear ssa else dequip.
local ONLY_IF_PLAYER = false     -- true/false wear amulet only if player on screen

-- DON'T EDIT BELOW THIS LINE

TYPE = string.lower(TYPE)

Module.New("Switch SSA", function (mod)
    local val = 0
    if TYPE == "mana" then
        val = Self.ManaPercent()
    else
        val = Self.HealthPercent()
    end 
    local amulet = Self.Amulet()
    local var = ((not ONLY_IF_PLAYER) or (ONLY_IF_PLAYER and table.count(Creature.iPlayers(7, false)) > 0)) 
    if val <= VALUE and var then
        if amulet.id ~= AMULET_ID then
            Self.EquipItem(SLOT_AMULET, AMULET_ID, 1)
        end
    else
        if amulet.id == AMULET_ID then
            Self.DequipItem(SLOT_AMULET) -- dequip amulet
        end
    end
    -- mod:Delay(200) delay execute script default disabled
end)
