--[[
    Script Name:        [on label] Buy mana fluids
    Description:        It's lua side where you will do actions on label buy potions.
    Author:             Ascer - example
]]

local BUY_UP_TO = 30        -- will buy to max this amount.


-- set params
local currentVials = 0

--> read label messages
function signal(label)
    if label == "shop" then
        buyFluidsUpTo(BUY_UP_TO)
    end
end
Walker.onLabel("signal")

--> read special messages in game
function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        local vials = string.match(msg.message, "Using one of (.+) vials...")
        if vials ~= nil then
            currentVials = tonumber(vials)
        end    
    end 
end 
Proxy.TextNew("proxyText")     

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       buyFluidsUpTo(amount)
--> Description:    Buy up to current x mana fluids using green message and command instant.
--> Params:         
-->                 @amount number how many vials you want to have after visiting shop.
--> Return:         boolean true or nil
----------------------------------------------------------------------------------------------------------------------------------------------------------
function buyFluidsUpTo(amount)
    Self.Say("instant sell vials")
    Self.UseItemWithMe(MANA_FLUID.id, 0)
    wait(1000)
    while true do
        wait(200) -- wait time to prevents program hang.
        if currentVials >= amount then return true end
        print(amount - currentVials)
        Self.Say("instant buy " .. amount - currentVials + 1 .. " mana fluids")
        wait(1500, 2000)
        Self.UseItemWithMe(MANA_FLUID.id, 0)
        wait(1500, 2000)
    end    
end