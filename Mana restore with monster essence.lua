--[[
    Script Name:        Mana restore with monster essence
    Description:        When detect monster essence item in opened containers then use it to restore mana.
    Author:             Ascer - example
]]


local MANA_BELOW = 70               -- when your mpperc is below o equal this value character will use MONSTER_ESSENCE_ID.
local SAFE_HEALTH = 50				-- dont restore mana if hpperc is below this value
local MONSTER_ESSENCE_ID = 1234     -- id of monster essence 
local RUNE_DELAY = {1000, 1200}     -- delay for use is default 1000ms we set a little bit higher.

-- DONT'T EDIT BELOW THIS LINE 

Module.New("Mana restore with monster essence", function ()
    if Self.ManaPercent() <= MANA_BELOW and Self.HealthPercent() > SAFE_HEALTH and Self.ItemCount(MONSTER_ESSENCE_ID) > 0 then 
        Self.UseItemWithMe(MONSTER_ESSENCE_ID, math.random(RUNE_DELAY[1], RUNE_DELAY[2]))
    end            
end)