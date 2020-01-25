--[[
    Script Name: 		Re-attack Monster
    Description: 		Keep attack monster by name. Re-check target after some time.
    Author: 			Ascer - example
]]

local ATTACK_MONSTER = "Monk" 	  -- name of monster.
local REATTACK_DELAY = 10		  -- minutes after we re-attack monster

-- DONT EDIT BELOW THIS LINE

local atkMonster, atkTime = string.lower(ATTACK_MONSTER), os.time()

Module.New("Re-attack Monster", function (mod)
    if os.time() - atkTime >= (REATTACK_DELAY * 60) then
    	atkTime = os.time()
    	Self.Stop()
    	wait(300)
    end	
    if Self.isConnected() and Self.TargetID() < 1 then
        local players = Creature.iMonsters(7, false)
        for i = 1, #players do
            local player = players[i]
       		if string.lower(player.name) == atkMonster then
       			Creature.Attack(player.id)
       			break
       		end	
        end
    end
    mod:Delay(300, 700)
end)
