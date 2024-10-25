--[[
    Script Name:        Use LootSeller Item on Main Backpack
    Description:        When your cap drop below CAP value then use ITEM_SELLER with main backpack. Important! seller item need to be in containers not EQ.
    Author:             Ascer - example
]]

local ITEM_SELLER = 15737    -- id of seller item
local CAP = 500             -- use only when cap below.

Module.New("Use LootSeller Item on Main Backpack", function(mod)
    if Self.isConnected() then
        if Self.Capity() < CAP then
            local seller = Container.FindItem(ITEM_SELLER)
            if table.count(seller) > 2 then
                Container.UseItemWithEquipment(seller.index, seller.slot, seller.id, SLOT_BACKPACK, Self.Backpack().id, 0)
            else
                -- show error item not found
                print("LootSeller item not found inside opened containers.")    
            end 
        end 
    end 
    mod:Delay(500)
end)