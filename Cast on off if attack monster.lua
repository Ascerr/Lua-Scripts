--[[
    Script Name:        Cast on off if attack monster.
    Description:        When you attacking monsters turn off cast else turn on.
    Author:             Ascer - example
]]

local CAST = {on = "!cast on", off = "!cast off", delay = 2000}   -- cast commands to on and off, delay between command say.

-- DONT EDIT BELOW THIS LINE

local spellTime = 0

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getAttackedMonster()
--> Description:    Return table with monster you attacking or nil if not attacking. 
--> Params:         
--> Return:         table = {id = ?, name = ?, x = ?, y = ?, z = ?, hpperc = ?, alive = ?, direction = ?, addr = ?, attack = ?, party = ?}
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getAttackedMonster()
    local target = Self.TargetID()
    if target <= 0 then return end
    target = Creature.getCreatures(target)
    if table.count(target) < 2 then return end
    return target 
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       delayedSay(text, delay)
--> Description:    Say text with delay.    
--> Params:         
-->                 @text string message to say on default channel.
-->                 @delay number miliseconds between say.
--> Return:         none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function delayedSay(text, delay)
    if os.clock() - spellTime > (delay / 1000) then
        Self.Say(text)
        spellTime = os.clock()
    end 
end


Module.New("Cast on off if attack monster", function ()
    
    -- set param for calculation.
    local can = false

    -- when connected 
    if Self.isConnected() then

        -- load attacked creature.
        local attack = getAttackedMonster()

        -- when is target.
        if attack ~= nil then

            -- disable cast
            delayedSay(CAST.off, CAST.delay)

        else

            -- enable cast
            delayedSay(CAST.on, CAST.delay)

        end 

    end         
    
end)