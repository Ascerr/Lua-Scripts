--[[
    Script Name: 		Refil Ammo
    Description: 		Refile ammuntion to your arrow slot or hand or quiver when amount drop down.
    Author: 			Ascer - example
]]

local AMMO = {
    id = 2667,              -- ammo id
    amount = 50,           -- when amount drop down to .. value restore.
    slot = SLOT_AMMO,     -- where we should put new part of ammo. SLOT_SHIELD, SLOT_WEAPON, SLOT_AMMO. If toQuiver = true then ignore this param
    toQuiver = false        -- true/false refill ammo to opened quiver container
}    

-- DON'T EDIT BELOW THIS LINE

local arrow

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       moveToQuiver(ammoID, ifBelow)
--> Description:    Move ammoID to opened quiver container ifBelow setted amount
--> Class:          Container
--> Params:         
-->                 @ammoID number id of ammo to refill
-->                 @ifBelow number amount when below we start moveing ammo.
--> Return:         nill - nothing  
----------------------------------------------------------------------------------------------------------------------------------------------------------
function moveToQuiver(ammoID, ifBelow)
    for i = 0, 15 do
        local quiver = Container.getInfo(i)
        if table.count(quiver) > 1 then
            if string.instr(quiver.name, "quiver") then -- here name of quiver
                local arrowsInQuiver = Self.ItemCount(ammoID, i)
                if arrowsInQuiver <= ifBelow then
                    local items = Container.getItems(special)
                    for j = 1, #items do
                        local cont = items[j]
                        local contItems = cont.items
                        if cont.index ~= i then
                            for k = 1, #contItems do
                                local item = contItems[k]
                                if item.id == ammoID then
                                    return Container.MoveItemToContainer(cont.index, (k - 1), i, 0, ammoID, item.count, 500)
                                end    
                            end
                        end     
                    end
                end    
            end    
        end    
    end
end    

-- module actions inside loop
Module.New("Refil Ammo", function (mod)
    if AMMO.slot == SLOT_WEAPON then
        arrow = Self.Weapon()
    elseif AMMO.slot == SLOT_SHIELD then
        arrow = Self.Shield()     
    else
        arrow = Self.Ammo()
    end
    
    if AMMO.toQuiver then
        moveToQuiver(AMMO.id, AMMO.amount) -- move arrows to quiver container
    else    
        if arrow.id ~= AMMO.id or arrow.count <= AMMO.amount then  -- check for different id or low amount
            local item = Container.FindItem(AMMO.id) -- find item
            if item ~= false then
                Container.MoveItemToEquipment(item.index, item.slot, AMMO.slot, item.id, item.count) -- shove to ammo slot
            end
        end
    end            
    mod:Delay(800, 1500)
end)
