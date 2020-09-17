--[[
    Script Name: 		SD Enemies
    Description: 		Shoot Sudden Death Rune in enemies depent on heal percent.
    Author: 			Ascer - example
]]

local USE_DELAY = {2000, 3000}          -- we can use rune each 2s
local SHOOT_BELOW = 30                  -- shoot sd below 30%
local ENEMIES = {"enemy1", "enemy2"}    -- add enemies with Capital letter
local RUNEID = 3155                     -- sd rune

-- DONT'T EDIT BELOW THIS LINE 

local useTime, useDelay = 0, 0

Module.New("SD Enemies", function ()
    if os.clock() - useTime < useDelay then -- check for time
        return
    end    
    for i, player in pairs(Creature.iPlayers(7)) do
        if table.find(ENEMIES, player.name) then
            if player.hpperc <= SHOOT_BELOW then
                Self.UseItemWithCreature(player, RUNEID)
                if Self.TargetID() ~= player.id then
                    Creature.Attack(player.id)
                end    
                useTime = os.clock()
                useDelay = math.random(USE_DELAY[1], USE_DELAY[2])/1000 -- set new random delay
                break -- end loop
            end    
        end
    end
end)
