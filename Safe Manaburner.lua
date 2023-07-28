--[[
    Script Name:        Safe Manaburner
    Description:        Cast spell only in specific conditions + antiidle
    Author:             Ascer - example
]]

local MANA_BURNER = {
    spell = "adevo grav flam",                          -- spell to cast
    when_mana_between = {240, 250},                     -- cast spell only when mana will between this values.
    pause_casting_if_mana_decreased_for = 20,           -- don't cast spell for next 100s if we deteced mana decreasing (you already casted spell)
    equip_blank_rune = {enabled = false, id = 3147},    -- equip blank rune to hand before rune make enabled - true/false, id of blank rune 
    ping = 1000                                         -- time in miliseconds between key functions like equip rune or cast spell
}

local ANTI_IDLE = {
    enabled = true,                 -- true/false enable random turn
    delay = {10, 15}                -- time in minutes between execute action
}


-- DON'T EDIT BELOW
local antiidleTime, antiidleDelay, antiidleDir, antiidleRandDir, antiidleRestore = 0, math.random(ANTI_IDLE.delay[1], ANTI_IDLE.delay[2]), -1, -1, false
local lastMana, manaburnerPause, manaburnerTime = Self.Mana(), false, 0
local blankPos, blankBackRune = {index = -1, slot = -1, id = -1, count = -1}, false
local randomManaToCast = MANA_BURNER.when_mana_between[1]

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
        blankBackRune = true
        manaburnerTime = os.clock()
        print("[Manaburner] Pause spell caster for: " .. MANA_BURNER.pause_casting_if_mana_decreased_for .. "sec due mana decreased.") 
        return
    end
    lastMana = mana 
    if mana >= MANA_BURNER.when_mana_between[1] and mana <= MANA_BURNER.when_mana_between[2] then
        if mana >= randomManaToCast then
            if MANA_BURNER.equip_blank_rune.enabled then
                if not wearBlankRune() then return end
            end    
            Self.Say(MANA_BURNER.spell)
            wait(MANA_BURNER.ping)
            randomManaToCast = math.random(MANA_BURNER.when_mana_between[1], MANA_BURNER.when_mana_between[2]) 
        end    
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

function wearBlankRune()
    if MANA_BURNER.equip_blank_rune.enabled then
        local weapon = Self.Weapon()
        if weapon.id == 0 then
            local blank = Container.FindItem(MANA_BURNER.equip_blank_rune.id)
            if table.count(blank) > 2 then
                blankPos = blank
                Container.MoveItemToEquipment(blank.index, blank.slot, SLOT_WEAPON, blank.id, 1, 0)
                wait(MANA_BURNER.ping)
                return false
            else
                Rifbot.PlaySound()
                print("[Manaburner]: There is no more blank runes.")
                return false
            end 
        elseif weapon.id ~= MANA_BURNER.equip_blank_rune.id then
            Self.DequipItem(SLOT_WEAPON)
        else
            if blankPos.index == -1 then
                local blank = Container.FindItem(MANA_BURNER.equip_blank_rune.id)
                if table.count(blank) > 2 then
                    blankPos = blank
                end    
            end    
            return true
        end   
    end    
end    

function putBackBlankRune()
    if not blankBackRune or not MANA_BURNER.equip_blank_rune.enabled then return end
    if blankPos.index ~= -1 then
        local weapon = Self.Weapon()
        if weapon.id ~= MANA_BURNER.equip_blank_rune.id and weapon.id ~= 0 then
            local dest = Container.getInfo(blankPos.index)
            if (table.count(dest) < 2 or (table.count(dest) >= 2 and dest.size == dest.amount)) then
                Self.DequipItem(SLOT_WEAPON)
            else
                Self.DequipItem(SLOT_WEAPON, blankPos.index, dest.size - 1)
            end    
        else
            blankBackRune = false
            blankPos = {index = -1, slot = -1, id = -1, count = -1}
            return true
        end        
    else
        blankBackRune = false
        blankPos = {index = -1, slot = -1, id = -1, count = -1}
        return true    
    end    
end    

Module.New("Safe Manaburner", function()
    if Self.isConnected() then
        manaburner()
        antiidle()
        putBackBlankRune()
    end    
end)
