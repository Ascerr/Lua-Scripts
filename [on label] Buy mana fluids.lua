--[[
    Script Name:        [on label] Buy mana fluids
    Description:        It's lua side where you will do actions on label buy potions.
    Author:             Ascer - example
]]

local config = {
    check = {label = "check", goto = "back", amount = 30},      -- when label "check" then if amount of vials <= 10 goto label "back"
    refill = {label = "shop", amount = 100}                     -- when label shop make refill (buy up to 30 vials)
}


-- set params
local currentVials = 0

--> read label messages
function signal(label)
    if label == config.refill.label then
        buyFluidsUpTo(config.refill.amount)
    elseif label == config.check.label then
        if currentVials < config.check.amount then
            Walker.Goto(config.check.goto)
        end    
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
        Self.Say("instant buy " .. amount - currentVials + 1 .. " mana fluids")
        wait(1500, 2000)
        Self.UseItemWithMe(MANA_FLUID.id, 0)
        wait(1500, 2000)
    end    
end
