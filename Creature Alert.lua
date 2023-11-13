--[[
    Script Name:        Creature Alert
    Description:        Play sound if any monster or player on screen. 
    Author:             Ascer - example
]]

local AMOUNT = 1                                                    -- amount of monsters to play alert
local DETECT = 2                                                    -- detect creature type, 0 - player, 1 - monster, 2 - both 
local SAFE_LIST = {"Defense Monster", "Friend2"}                    -- Safe list. Names need to by with Capital letter.
local SPECIAL_LIST = {enabled = false, names = {"Rat", "Snake"}}    -- enabled = true/false if you want check for special names. Use Capital letter.
local MULTIFLOOR = false                                            -- true/false check creatures on multifloors

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
    
    -- set default count
    local count = 0

    -- inside loop for creatures
    for i, cre in pairs(Creature.iFunction(c, 7, MULTIFLOOR)) do
        
        -- when creature is not friend and we chek only for players/monsters or both and creature is not NPC
        if not table.find(SAFE_LIST, cre.name) and (DETECT < 2 or not Creature.isNpc(cre)) then
            
            -- check if is enabled checking for special list
            local var = (not SPECIAL_LIST.enabled or (SPECIAL_LIST.enabled and table.find(SPECIAL_LIST.names, cre.name)))

            -- check if var is valid.
            if var then

                -- add count
                count = count + 1

                -- play sound only if enough count
                if count >= AMOUNT then

                    -- play sound for more search in Rifbot Lib.lua -> RIFBOT_SOUNDS = []
                    playSound("Creature Detected.mp3") 
                    
                    -- break loop
                    break 

                end    
            
            end    

        end
    
    end  

end)
