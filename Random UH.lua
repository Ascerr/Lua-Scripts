--[[
    Script Name: 		Auto Potion
    Description: 		Restore your character mana
    Author: 			Ascer - example
]]

local RUNE_DELAY = {1000, 1500}     -- delay for Pot is default 1000ms we set a little bit higher.
local MANA_BELOW = 50               -- when your mpperc is below o equal this value character will use POTIONID.
local POTIONID = 6374                 -- UH id 

-- DONT'T EDIT BELOW THIS LINE 

local mainDelay, mainTime = 0, 0

Module.New("Auto Potion", function ()
    if Self.ManaPercent() <= MANA_BELOW then 
        Self.UseItemWithMe(POTIONID, math.random(RUNE_DELAY[1], RUNE_DELAY[2]))
    end            
end)