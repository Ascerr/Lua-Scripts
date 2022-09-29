--[[
    Script Name:        Safe Manaburner
    Description:        Cast spell only in specific conditions + antiidle
    Author:             Ascer - example
]]

local MANA_BURNER = {
    spell = "exura",                            -- spell to cast
    when_mana_between = {25, 27},               -- cast spell only when mana will between this values.
    play_sound_if_mana_above = false,           -- will play sound when mana will above this values (GM charging you or you make wrong calculation about mana regen)
    pause_casting_if_mana_decreased_for = 20     -- don't cast spell for next 100s if we deteced mana decreasing (you already casted spell)
}

local ANTI_IDLE = {
    enabled = true,                 -- true/false enable random turn
    delay = {10, 15}                -- time in minutes between execute action
}


-- DON'T EDIT BELOW
local antiidleTime, antiidleDelay, antiidleDir, antiidleRandDir, antiidleRestore = 0, math.random(ANTI_IDLE.delay[1], ANTI_IDLE.delay[2]), -1, -1, false
local lastMana, manaburnerPause, manaburnerTime = Self.Mana(), false, 0


function manaburner()
    local mana = Self.Mana()
    if manaburnerPause then
        lastMana = mana
        if os.clock() - manaburnerTime > MANA_BURNER.pause_casting_if_mana_decreased_for then
            manaburnerPause = false
            manaburnerTime = 0
        end
        return    
    end    
    if lastMana - mana > 0 then
        manaburnerPause = true
        manaburnerTime = os.clock()
        print("[Manaburner] Pause spell caster for: " .. MANA_BURNER.pause_casting_if_mana_decreased_for .. " due mana decreased.") 
        return
    end
    lastMana = mana 
    if mana >= MANA_BURNER.when_mana_between[1] and mana <= MANA_BURNER.when_mana_between[2] then
        Self.Say(MANA_BURNER.spell)
        wait(1000)
    elseif mana > MANA_BURNER.when_mana_between[2] then
        Rifbot.PlaySound()
        print("[Manaburner] Detected mana above limit: " .. mana .. " while limit is " .. MANA_BURNER.when_mana_between[2])    
    end    
end    


function antiidle()
    if ANTI_IDLE.enabled then
        if os.clock() - antiidleTime >= (antiidleDelay * 60) then
            if antiidleDir == -1 then
                antiidleDir = Self.Direction()
            end
            if antiidleDir ~= -1 then
                local dirTable = {}
                for i = 0, 3 do
                    if i ~= antiidleDir then
                        table.insert(dirTable, i)
                    end    
                end
                if antiidleRandDir == -1 then
                    antiidleRandDir = dirTable[math.random(1, #dirTable)]
                end
                if antiidleRandDir ~= -1 then
                    if Self.Direction() ~= antiidleRandDir and not antiidleRestore then
                        Self.Turn(antiidleRandDir)
                    else
                        antiidleRestore = true
                        if Self.Direction() ~= antiidleDir then
                            Self.Turn(antiidleDir)
                        else    
                            antiidleDir = -1
                            antiidleRandDir = -1
                            antiidleDelay = math.random(ANTI_IDLE.delay[1], ANTI_IDLE.delay[2])
                            antiidleTime = os.clock()
                            antiidleRestore = false
                        end       
                    end
                end        
            end    
        end    
    end    
end 


Module.New("Safe Manaburner", function()
    if Self.isConnected() then
        manaburner()
        antiidle()
    end    
end)