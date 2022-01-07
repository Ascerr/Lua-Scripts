--[[
    Script Name:        Turn on cast at low target hpperc.
    Description:        When you attacking monster and it have less than x hpperc turn on cast to gain some extra exp else turn off.
    Author:             Ascer - example
]]

local CAST = {
    on = "!cast on",            -- command cast on
    off = "!cast off",          -- command cast off
    hpperc = 30,                -- turn on cast when monster hpperc below this value
    waitUntilDisable = 1000,    -- wait this time before disable cast after monster killed.
    delay = 2000                -- delay between command say.
}

-- DONT EDIT BELOW THIS LINE

local spellTime, castTime, castEnabled = 0, 0, false

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

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       setCastEnabled(state, delay)
--> Description:    Say command to disable or enable cast.    
--> Params:         
-->                 @state boolean true or false enable cast.
-->                 @delay number miliseconds between say.
--> Return:         none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function setCastEnabled(state, delay)
    if delay == nil then delay = CAST.delay end
    if state then
        if not castEnabled then 
            castEnabled = true
            delayedSay(CAST.on, delay)  
        end
    else
        if castEnabled then 
            castEnabled = false 
            delayedSay(CAST.off, delay)
        end
    end    
end    


Module.New("Turn on cast at low target hpperc", function ()
    
    -- when connected 
    if Self.isConnected() then

        -- load attacked creature.
        local attack = getAttackedMonster()

        -- when is target.
        if attack ~= nil then

            -- when target has low hpperc
            if attack.hpperc <= CAST.hpperc then

                setCastEnabled(true)

                -- set cast time
                castTime = os.clock()

            else    

               -- disable cast 
               setCastEnabled(false)

            end    

        else

            -- disable cast when time out
            if os.clock() - castTime >= (CAST.waitUntilDisable / 1000) then

                -- disable cast
                setCastEnabled(false)

            end    
            
        end 

    end         
    
end)