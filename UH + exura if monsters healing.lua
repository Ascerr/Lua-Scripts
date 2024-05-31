--[[
    Script Name: 		UH + exura if monsters heaing
    Description: 		Heal your character using exura and uhs depend on monsters amount.
    Author: 			Ascer - example
]]


local MAIN_DELAY = {300, 500}                               -- loop reading values time
local SPELL_DELAY = {500, 1000}                             -- time in miliseconds between cast spell
local RUNE_DELAY = {1000, 2100}                             -- random time between using healing rune. You can use each 1s but..

local HEALING = {
    monsters_2_or_less = {spell = "exura", spell_hpperc = 90, mana = 25, item = 3160, rune_hpperc = 50}, -- if 2 monsters or less first use spell to heal and if hp drop drastically then uh
    monsters_3_or_more = {item = 3160, rune_hpperc = 70},   -- when 3 monsters or more heal with uhs only
    monsters_range = 3                                      -- range we checking for monsters near your
}

-- DON'T EDIT BELOW THIS LINE

function getMonsters()
    return table.count(Creature.iMonsters(HEALING.monsters_range, false))
end  --> return amount of monsters 2 sqms from your character   

Module.New("UH + exura if monsters heaing", function (mod)
    if Self.isConnected() then
        local selfHpperc, selfMana, monsters = Self.HealthPercent(), Self.Mana(), getMonsters()
        if monsters <= 2 then
            if selfHpperc <= HEALING.monsters_2_or_less.rune_hpperc and selfMana > EALING.monsters_2_or_less.mana then
                Self.UseItemWithMe(HEALING.monsters_2_or_less.item, math.random(RUNE_DELAY[1], RUNE_DELAY[2]))
            else
                if selfHpperc <= HEALING.monsters_2_or_less.spell_hpperc then
                    Self.CastSpell(HEALING.monsters_2_or_less.spell, HEALING.monsters_2_or_less.mana, math.random(SPELL_DELAY[1], SPELL_DELAY[2]))
                end   
            end    
        else
            if selfHpperc <= HEALING.monsters_3_or_more.rune_hpperc then
                Self.UseItemWithMe(HHEALING.monsters_3_or_more.item, math.random(RUNE_DELAY[1], RUNE_DELAY[2]))
            end    
        end    
    end                 
    mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)