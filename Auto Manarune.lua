--[[
    Script Name:        Auto Manarune
    Description:        Restore your character mana using manarune
    Author:             Ascer - example
]]

local RUNE_DELAY = {1000, 1200}     -- delay for Pot is default 1000ms we set a little bit higher.
local MANA_BELOW = 70               -- when your mpperc is below o equal this value character will use POTIONID.
local SAFE_HEALTH = 50				-- dont restore mana if hpperc is below this value
local POTIONID = 3157               -- manarune id (3157 - weak)

-- DONT'T EDIT BELOW THIS LINE 

Module.New("Auto Manarune", function ()
    if Self.ManaPercent() <= MANA_BELOW and Self.HealthPercent() > SAFE_HEALTH then 
        Self.UseItemWithMe(POTIONID, math.random(RUNE_DELAY[1], RUNE_DELAY[2]))
    end            
end)