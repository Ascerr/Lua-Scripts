--[[
    Script Name: 		Wait For Spawn
    Description: 		Logout when spawn is empty and login after x time.
    Author: 			Ascer - example
]]

local SPAWN_MONSTERS = {"rotworm", "troll", "rat"}  -- monsters separated by comma we looking.
local SPAWN_RANGE = 7  -- max distane between you and monster default 7 = on screen
local SPAWN_WAIT = 10  -- wait 10 min for spawn (not sure if 10min is enought need to test)

-- DON'T EDIT BELOW THIS LINE

local logoutTime

Module.New("Wait For Spawn", function (mod)
    if Self.isConnected() then
        local count = 0
        local monsters = table.lower(SPAWN_MONSTERS) -- case lower all table with mosters
        for i, mob in pairs(Creature.iMonsters(SPAWN_RANGE, false)) do
            if table.find(monsters, string.lower(mob.name)) then
                count = count + 1
                break -- break loop we don't need more here.
            end
        end
        if count == 0 then -- do action only when no monsters
            if not Self.isInFight() then
                logoutTime = os.clock()
                Self.Logout()
                wait(500, 1800)
            end  
        end        
    else
        printf("Successfully logout due a no monsters. Relogin for " .. math.floor((SPAWN_WAIT * 60) - (os.clock() - logoutTime)) .. "s." )
        wait(800, 1200)
        if os.clock() - logoutTime > (60 * SPAWN_WAIT) then
            Rifbot.PressKey(13)  -- press enter key 
        end
    end
    mod:Delay(1500, 3000)        
end)