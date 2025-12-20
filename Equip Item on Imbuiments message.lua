--[[
    Script Name:        Equip Item on Imbuiments message
    Description:        If appear message about imbuiments expired then equip new item to selected slot in eq.
    Author:             Ascer - example
]]

local EQ_SLOT = SLOT_WEAPON                     -- slot from eq where we will put new item
local ITEMID = 3031                             -- item id to equip
local KEYWORDS = {"has expired from your"}      -- keywords we looking for

-- DON'T EDIT BELOW THIS LINE
local wear = false

function isKeyword(msg)
    for i = 1, #KEYWORDS do
        if string.instr(msg, KEYWORDS[i]) then
            return true
        end 
    end
    return false    
end --> check if specific keyword from possible keywords list appear in message 

--> module execute equip action
Module.New("Equip Item on Imbuiments message", function()
    if Self.isConnected() then
        if wear then
            wait(1000)
            Self.EquipItem(EQ_SLOT, ITEMID, 1, 0)
            wear = false
        end    
    end    
end)

--> proxy catch message
function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        if isKeyword(msg.message) then
            wear = true
            print("proxyText: " .. msg.message, msg.mode)
        end     
    end 
end
Proxy.TextNew("proxyText")