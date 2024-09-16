--[[
    Script Name:        Use Area Rune on you if dmg from stalker.
    Description:        When Stalker hits you dmg then character auto use rune with yourself.
    Author:             Ascer - example
]]

local MONSTER = "Stalker"
local SHOOT_RUNE = {id = 3161, dontUseIfPlayer = true, delay = 2000}

-- DON'T EDIT BELOW THIS LINE

function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        if string.instr(msg.message, "You lose") and string.instr(msg.message, MONSTER) then
            local player = table.count(Creature.iPlayers(7, false))
            if (not SHOOT_RUNE.dontUseIfPlayer or (SHOOT_RUNE.dontUseIfPlayer and player <= 0)) then
                Self.UseItemWithMe(SHOOT_RUNE.id, SHOOT_RUNE.delay)
            end    
        end    
    end 
end 
Proxy.TextNew("proxyText") 
