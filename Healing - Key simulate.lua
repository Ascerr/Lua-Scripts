--[[
    Script Name: 		Healing - Key simulate
    Description: 		Heal your character using keyboard simulate.
    Author: 			Ascer - example
]]

local MAIN_DELAY = {300, 500}                               -- loop reading values time
local KEY_DELAY = {500, 1000}                               -- time in miliseconds between press key

local HEALING = {
    {key = 0x70, hpperc = 50, mana = 80},                  -- More important healing comes first in the table.
    {key = 0x71, hpperc = 70, mana = 40},                  -- key in hex value 0x70 = F1, more you can find: http://www.kbdedit.com/manual/low_level_vk_list.html 
    {key = 0x72, hpperc = 90, mana = 25}


    -- {item = 0x73, hpperc = 40, mana = 60}  -- you can add more
}

Module.New("Healing - Key simulate", function (mod)
    if Self.isConnected() then
        local selfHpperc, selfMana = Self.HealthPercent(), Self.Mana()
        for i, mode in pairs(HEALING) do
            if selfHpperc <= mode.hpperc and selfMana >= mode.mana then
                Rifbot.PressKey(mode.key, math.random(KEY_DELAY[1], KEY_DELAY[2]))
                break    
            end
        end
    end                     
    mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)