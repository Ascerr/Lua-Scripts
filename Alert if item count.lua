--[[
    Script Name:        Alert if item count
    Description:        Play sound your character if item count is below x value.
    Author:             Ascer - example
]]

local ITEM = {id = 2853, count = 2}  -- item.id and item.count.

-- DON'T EDIT BELOW THIS LINE.


-- Module to run functions in loop 200ms.
Module.New("Alert if item count", function ()
    if Self.isConnected() then
        if Self.ItemCount(ITEM.id) < ITEM.count then
            Rifbot.PlaySound("Default.mp3")
        end
    end        
end)
