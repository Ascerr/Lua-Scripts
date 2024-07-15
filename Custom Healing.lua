--[[
    Script Name: 		Custom Healing
    Description: 		Heal your character using spells and runes.
    Author: 			Ascer - example
]]

local MAIN_DELAY = {300, 500}                               -- loop reading values time
local SPELL_DELAY = {500, 1000}                             -- time in miliseconds between cast spell
local RUNE_DELAY = {1000, 2100}                             -- random time between using healing rune. You can use each 1s but..
local USE_ONLY_IF_MONSTER_ON_SCREEN = false                 -- true/false enable healing only when monsters on screen (true) or default (false) use no matter if monster or not.

local HEALING = {
    {item = "exura vita", hpperc = 50, mana = 80},          -- More important healing comes first in the table.
    {item = "exura gran", hpperc = 70, mana = 40},
    {item = "exura", hpperc = 90, mana = 25}


    -- {item = 'exura sio "Name', hpperc = 40, mana = 60},  -- example of exura sio not used already
    -- {item = 3160, hpperc = 60, mana = 0},                 -- example of using uhs @item must be number.
}

Module.New("Custom Healing", function (mod)
    if Self.isConnected() then
        local selfHpperc, selfMana = Self.HealthPercent(), Self.Mana()
        if (not USE_ONLY_IF_MONSTER_ON_SCREEN or (USE_ONLY_IF_MONSTER_ON_SCREEN and Creature.iMonsters(7,false) > 0)) then
            for i, mode in pairs(HEALING) do
                if selfHpperc <= mode.hpperc and selfMana >= mode.mana then
                    if type(mode.item) == "string" then
                        Self.CastSpell(mode.item, mode.mana, math.random(SPELL_DELAY[1], SPELL_DELAY[2])) -- use spell
                        break    
                    else
                        if Self.UseItemWithMe(mode.item, math.random(RUNE_DELAY[1], RUNE_DELAY[2])) then -- check if use rune is valid when true break loop
                            break
                        end    
                    end
                end
            end
        end    
    end                     
    mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)
