--[[
    Script Name:        Creature Alert
    Description:        Play sound if any monster or player on screen. 
    Author:             Ascer - example
]]

local DETECT = 2                                 -- detect creature type, 0 - player, 1 - monster, 2 - both 
local SAFE_LIST = {"Defense Monster", "Friend2"} -- Safe list. Names need to by with Capital letter.

Module.New("Creature Alert", function ()
    
    -- set var for table with players.
    local c = "players"

    -- when detect = 1 set monsters
    if DETECT == 1 then
    
        -- set var for monsters
        c = "monsters"

    elseif DETECT == 2 then

        -- set for both.
        c = "creatures"

    end    
        
    -- inside loop for creatures
    for i, cre in pairs(Creature.iFunction(c, 7, false)) do
        
        -- when creature is not friend and we chek only for players/monsters or both and creature is not NPC
        if not table.find(SAFE_LIST, cre.name) and (DETECT < 2 or not Creature.isNpc(cre)) then
            
            -- play sound for more search in Rifbot Lib.lua -> RIFBOT_SOUNDS = []
            playSound("Creature Detected.mp3") 
            
            -- break loop
            break 
        
        end
    
    end  

end)