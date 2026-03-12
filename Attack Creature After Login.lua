--[[
    Script Name:        Attack Creature After Login
    Description:        After login to game attack creature, eat food and cast spell then let game client to logout you after 15min+. Bot will auto reconnect to game.
    Author:             Ascer - example
]]

local DUMMY = "Training Dummy"              -- name of training dummy creature
local FOOD = {3586, 3587, 3588, 3589}       -- food ids
local FOOD_EAT_TRIES = 3                    -- how many times to use food.
local SPELL = "exura"                       -- spell to cast
local SPELL_TIMES = 2                       -- how many times cast spell

-- DON'T EDIT BELOW THIS LINE

DUMMY = string.lower(DUMMY)
local action = true

Module.New("Attack Creature After Login", function ()
    if Self.isConnected() then
        wait(3000) -- wait some time to don't perform actions quick after login
        if action then
            if Self.TargetID() == 0 then
                local c = Creature.getCreatures(DUMMY)
                if table.count(c) > 1 then
                    Creature.Attack(c.id)
                end    
            end
            local foodItem = Container.FindItem(FOOD)
            if table.count(foodItem) then
                for i = 1, FOOD_EAT_TRIES do
                    Self.UseItemWithMe(foodItem.id, 500) -- use food
                    wait(800, 1200)
                end    
            end
            for j = 1, SPELL_TIMES do
                Self.Say(SPELL) -- cast spell
                wait(2000, 3000)
            end    
            action = false
        end    
    else
        wait(3000)
        action = true
        Rifbot.PressKey(13, 2000) -- press enter every 2s
    end 
end)