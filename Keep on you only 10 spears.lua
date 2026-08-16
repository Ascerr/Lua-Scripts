--[[
    Script Name:        Keep on you only 10 spears
    Description:        Drop spears or other item from weapon slot and container if total amount is above 10.
    Author:             Ascer - example
]]

local SPEAR_ID = 3031                       -- spear id
local QUANTITY = 10                         -- keep in weapon slot + opened containers only this amount, all over it drop on ground under your character.

Module.New("Keep on you only 10 spears", function(mod)
    if Self.isConnected() then
        local weapon = Self.Weapon()
        local amount = 0 
        local containersAmount = Self.ItemCount(SPEAR_ID)
        if weapon.id == SPEAR_ID then
            amount = weapon.count
        end    
        local me = Self.Position()
        if amount > QUANTITY then
            Container.MoveItemFromEquipmentToGround(SLOT_WEAPON, me.x, me.y, me.z, SPEAR_ID, weapon.count - QUANTITY) -- drop extra spears from weapon slot.
        else
            if (amount + containersAmount) > QUANTITY then
                local item = Container.FindItem(SPEAR_ID)
                if table.count(item) > 1 then
                    Container.MoveItemToGround(item.index, item.slot, me.x, me.y, me.z, SPEAR_ID, (amount + containersAmount) - QUANTITY)  -- drop spears from containers.
                end    
            end    
        end    
    end
    mod:Delay(500, 800)
end)
