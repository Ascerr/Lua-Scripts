--[[
    Script Name:        Safe Mana Fluid
    Description:        Restore your character mana using mana fluid not instant but with human delay after decresing mana.
    Author:             Ascer - example
]]

local FLUID_DELAY = {1000, 1500}             -- delay for fluid is default 1000ms we set a little bit higher.
local HUMAN_SLOW_DOWN_DELAY = {2000, 3000}  -- reacts on decresing mana with higher delay not instant
local MANA_BELOW = 70                       -- when your mpperc is below o equal this value character will use POTIONID.
local SAFE_HEALTH = 50				        -- dont restore mana if hpperc is below this value
local MANA_FLUID_ID = 2874                  -- id of mana fluid


-- DONT'T EDIT BELOW THIS LINE 
local startTime, waitDelay = 0, 0

Module.New("Safe Mana Fluid", function ()
    if Self.isConnected() then
        if Self.ManaPercent() <= MANA_BELOW then 
            if startTime == 0 then
                startTime = os.clock()
                waitDelay = math.random(HUMAN_SLOW_DOWN_DELAY[1], HUMAN_SLOW_DOWN_DELAY[2])
            else
                if os.clock() - startTime >= (waitDelay/1000) then
                    if Self.HealthPercent() >= SAFE_HEALTH then
                        Self.UseItemWithMe(MANA_FLUID_ID, math.random(FLUID_DELAY[1], FLUID_DELAY[2]))
                    end    
                end    
            end
        else          
            startTime = 0 -- more than enough mana restart time and waits for next drop down.
        end
    end                
end)