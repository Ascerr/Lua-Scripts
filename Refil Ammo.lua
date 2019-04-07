--[[
    Script Name: 		Refil Ammo
    Description: 		Refile ammuntion to your arrow slot or hand when amount drop down.
    Author: 			Ascer - example
]]

local AMMO = {
    id = 2667,      -- ammo id
    amount = 50,     -- when amount drop down to .. value restore.
    slot = SLOT_WEAPON -- where we should put new part of ammo. SLOT_SHIELD, SLOT_WEAPON, SLOT_AMMO
}    

-- DON'T EDIT BELOW THIS LINE

local arrow

Module.New("Refil Ammo", function (mod)
    if AMMO.slot == SLOT_WEAPON then
        arrow = Self.Weapon()
    elseif AMMO.slot == SLOT_SHIELD then
        arrow = Self.Shield()
    else
        arrow = Self.Ammo()
    end                
    if arrow.id ~= AMMO.id or arrow.count <= AMMO.amount then  -- check for different id or low amount
        local item = Container.FindItem(AMMO.id) -- find item
        if item ~= false then
            Container.MoveItemToEquipment(item.index, item.slot, AMMO.slot, item.id, item.count) -- shove to ammo slot
        end
    end        
    mod:Delay(800, 1500)
end)
