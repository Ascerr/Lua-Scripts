--[[
    Script Name:        [on label] Check Assassin Start + proxy for MFs
    Description:        It's lua side where you will check for assassin starts and mana fluids (green message) and go to label back is low.
    Required:           Valid message for catch mana fluids.
    Author:             Ascer - example
]]

local config = {
    labelCheck = "check",                               -- only if character stay during cavebot on this label check will make.
    assassinStars = {id = 1111, amount = 40},           -- when low amount of assasin starts go to label back
    manaFluids = {id = 2854, amount = 18},              -- when low amount of go to label back.
    labelBack = "back"                                  -- label to go.
}


-- DONT EDIT BELOW THIS LINE


-- set params for start count
local currentVials = 20000

--> get current amount of assassin start inside eq + containers
function getStars()
    local stars = 0
    local weapon = Self.Weapon()
    local shield = Self.Shield()
    local ammo = Self.Ammo()
    if weapon.id == config.assassinStars.id then stars = stars + weapon.count end
    if shield.id == config.assassinStars.id then stars = stars + shield.count end
    if ammo.id == config.assassinStars.id then stars = stars + ammo.count end
    return stars + Self.ItemCount(config.assassinStars.id)
end    

--> read label messages
function signal(label)
    if label == config.labelCheck then
        if currentVials <= config.manaFluids.amount or getStars() <= config.assassinStars.amount then
            print("Low amount of assassin stars or mana fluids goto label: " .. config.labelBack)
            Walker.Goto(config.labelBack)
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




