--[[
    Script Name: 		Refil Ammo
    Description: 		Refile ammuntion to your arrow slot when amount drop down.
    Author: 			Ascer - example
]]

local AMMO = {
    id = 2667,      -- ammo id
    amount = 90     -- when amount drop down to .. value restore.
}    

-- DON'T EDIT BELOW THIS LINE

Module.New("Refil Ammo", function (mod)
    local arrow = Self.Ammo()
    if arrow.id ~= AMMO.id or arrow.count <= AMMO.amount then  -- check for different id or low amount
        local item = Container.FindItem(AMMO.id) -- find item
        if item ~= false then
            Container.MoveItemToEquipment(item.index, item.slot, SLOT_AMMO, item.id, item.count) -- shove to ammo slot
        end
    end        
    mod:Delay(800, 1500)
end)