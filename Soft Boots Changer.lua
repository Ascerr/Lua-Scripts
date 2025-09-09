--[[
    Script Name: 		Soft Boots Changer
    Description: 		Load a new softs boots from backpacks if other worn or use equipment slot to auto charge or use special item with soft.
    Author: 			Ascer - example
]]

local config = {
    soft_boots = {new = 6529, using = 3549, worn = 6530},       -- id for soft boots: [new] - brand new in backpack, [using] - working in equipment, [worn] - run out of time boots.
    useEquipmentSlotToCharge = false,                           -- allow to use worn equipment boots to charge it.
    repairWithItem = {enabled = false, item = 1234},            -- @enabled: true/false use item with to repair soft boots, @item - id to use with.
    repairWithCommand = {enabled = false, text = "!soft"}       -- @enabled: true/false say command to recharged softs. @text - command to say
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Soft Boots Changer", function (mod)
    
	-- load feet.
	local feet = Self.Feet().id

	-- when feet contains worn soft boots
    if feet == config.soft_boots.worn then

        -- if allow to use feet slot
        if config.useEquipmentSlotToCharge then

            -- use equimpent feet slot.
            Self.UseItemFromEquipment(SLOT_FEET)

        elseif config.repairWithItem.enabled then

            local itemToUseWith = Container.FindItem(config.repairWithItem.item, nil)

            if table.count(itemToUseWith) > 1 then
                Container.UseItemWithEquipment(itemToUseWith.index, itemToUseWith.slot, itemToUseWith.id, SLOT_FEET, config.soft_boots.worn) 
            end

        elseif config.repairWithCommand.enabled then    

            Self.Say(config.repairWithCommand.text)
            wait(2500)

        else
            
            -- dequip boots to backpack
            Self.DequipItem(SLOT_FEET)

        end    

    -- when equipment contains new eq boots (GAME BUG)
    elseif feet == config.soft_boots.new then    

        -- dequip boots to backpack
        Self.DequipItem(SLOT_FEET)

    -- when no boots in eq    
    elseif feet == 0 then    
        
        -- equip soft boots
        Self.EquipItem(SLOT_FEET, config.soft_boots.new, 1, math.random(500, 800))

    end    

end)

