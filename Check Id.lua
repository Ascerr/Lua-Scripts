--[[
    Script Name:        Check Id
    Description:        Check ItemID inside Arrow Slot
    Author:             Ascer - example
]]

-- DONT'T EDIT BELOW THIS LINE 


Module.New("Auto Potion", function ()
    local arrowSlot = Self.Ammo()
    printf("Item id inside arrow slot is " .. arrowSlot.id)         
end)