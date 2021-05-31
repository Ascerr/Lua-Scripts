--[[
    Script Name:        Cast Spell On Time
    Description:        Cast spell every some time.
    Author:             Ascer - example
]]

local SPELL = "utevo lux"           -- spell we will cast in game
local EVERY_TIME_SECONDS = 80       -- every this time in seconds will countinue cast spell
local ADD_RANDOM = false            -- add random time +5, 10 seconds [true/false]
local IF_PLAYER_DONT_CAST = true    -- don't cast if on screen, ignore players from Friends.txt
local WEAR_BLANK_RUNE = false       -- wear blank rune before casting spell
local BLANK_RUNE_ID = 2260          -- id of blank rune

-- DONT'T EDIT BELOW THIS LINE

local mainTime, randomTime, friends = 0, 0, Rifbot.FriendsList(true)


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getPlayer()
--> Description:    Check for player on screen, ignore Friends.txt list.
--> Params:         
-->
--> Return:         boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPlayer()
    if not IF_PLAYER_DONT_CAST then return false end
    for i, c in ipairs(Creature.iPlayers(7, false)) do
        if not table.find(friends, string.lower(c.name)) then
            return true
        end
    end
    return false    
end    

-- mod to run functions
Module.New("Cast Spell On Time", function ()
    
    -- check if we should cast.
    if (os.clock() - mainTime) >= (EVERY_TIME_SECONDS + randomTime)  then
        
        -- if we are connected to game.
        if Self.isConnected() then

            -- when checking
            if not getPlayer() then 

                -- when equiping blanks
                if WEAR_BLANK_RUNE then

                    -- equip blank rune
                    Self.EquipItem(SLOT_WEAPON, BLANK_RUNE_ID, 1, 0)

                    -- wait time after equip blank (1000ms = 1s)
                    wait(3000)

                end 

                -- cast spell
                Self.CastSpell(SPELL, 0)

                -- set time casting spell   
                mainTime = os.clock()

                -- if we adding extra random time
                if ADD_RANDOM then

                    -- set random time
                    randomTime = math.random(5, 10)

                end

            else        

                -- set checking for next 10s  
                mainTime = os.clock() - EVERY_TIME_SECONDS + 10

            end

        end

    end        

end) 
