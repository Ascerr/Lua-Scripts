--[[
    Script Name: 		Dequip Boots of Haste if player
    Description: 		If player on screen take off boh, else equip. 
    Author: 			Ascer - example
]]
            
local BOOTS = 3079                          -- id of soft boots
local DEQUIP_CONTAINTER_INDEX = 0           -- dequip only to first container (0, 1 - second) to don't lost boots in dead monsters.
local SAFE_LIST = {"Friend1", "Friend2"}    -- add here friends to avoid.

-- DON'T EDIT BELOW THIS LINE

local friends = table.lower(SAFE_LIST)

Module.New("Dequip Boots of Haste if player", function ()
    if Self.isConnected() then
        local isPlayer = false
        for i, player in pairs(Creature.iPlayers(7)) do
            if not table.find(friends, player.name) then
                isPlayer = true
            end
        end
        if isPlayer then
            if Self.Feet().id == BOOTS then
                local contTo = Container.getInfo(DEQUIP_CONTAINTER_INDEX)
                if table.count(contTo) > 0 then
                    if contTo.size == contTo.amount then
                        print("Container index " .. DEQUIP_CONTAINTER_INDEX .. " is full.")
                    else 
                        Self.DequipItem(SLOT_FEET, DEQUIP_CONTAINTER_INDEX, contTo.amount, 500) -- delay 0.5s
                    end    
                else    
                    print("Container index " .. DEQUIP_CONTAINTER_INDEX .. " is closed.")
                end
            end    
        else
            if Self.Feet().id ~= BOOTS then
                Self.EquipItem(SLOT_FEET, BOOTS, 1, 500)
            end    
        end
    end           
end)