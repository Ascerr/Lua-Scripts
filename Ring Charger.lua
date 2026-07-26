--[[
    Script Name:        Ring Charger
    Description:        Charge ring with special item if worn or replace with brand new in backpack
    Author:             Ascer - example
]]

local config = {
    ring = {new = 6529, using = 3549, worn = 6530},             -- id for ring: [new] - brand new in backpack, [using] - working in equipment, [worn] - run out of time.
    useEquipmentSlotToCharge = false,                           -- allow to use worn equipment boots to charge it.
    repairWithItem = {enabled = false, item = 1234},            -- @enabled: true/false use item with to repair soft boots, @item - id to use with.
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Ring Charger", function (mod)
    
    -- load finder.
    local finger = Self.Ring().id

    -- when finger contains worn soft boots
    if finger == config.ring.worn then

        -- if allow to use finger slot
        if config.useEquipmentSlotToCharge then

            -- use equimpent finger slot.
            Self.UseItemFromEquipment(SLOT_RING)

        elseif config.repairWithItem.enabled then

            local itemToUseWith = Container.FindItem(config.repairWithItem.item, nil)

            if table.count(itemToUseWith) > 1 then
                Container.UseItemWithEquipment(itemToUseWith.index, itemToUseWith.slot, itemToUseWith.id, SLOT_RING, config.ring.worn) 
            end

        else
            
            -- dequip ring to backpack
            Self.DequipItem(SLOT_RING)

        end    

    -- when equipment contains new eq ring (GAME BUG)
    elseif finger == config.ring.new then    

        -- dequip boots to backpack
        Self.DequipItem(SLOT_RING)

    -- when no ring in eq    
    elseif finger == 0 then    
        
        -- equip ring
        Self.EquipItem(SLOT_RING, config.ring.new, 1, math.random(500, 800))

    end    

end)
