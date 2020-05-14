--[[
    Script Name:        Step back on DMG taken 
    Description:        Step to ground x, y, z when any dmg taken.
    Author:             Ascer - example
]]

local STEP_POS = {32312, 31795, 6}  -- our house position or safe area to hide when dmg
local STEP_BACK = {enabled = true, logout = false, pos = {32311, 31795, 6}, delay = 6}    -- return to previus position when will safe, @eabled - true/false, @logout - true/false after step to save pos @pos - {x, y, z}, @delay - minutes
local IF_PUSHED_GO_TO_SAFE_POS = true       -- when your char will pushed then will back to safe pos (you can edit wait time inside file to make step faster.)
local IF_CREATURE_GO_TO_SAFE_POS = false    -- when creature, monster or player go to safe pos.
local KEY_WORDS = {"You lose"}              -- set keyword for activate
local FRIENDS = {"Friend1", "Friend2"}      -- friend list to avoid, name with capital letters.

-- DON'T EDIT BELOW THIS LINE

local stepTime, lastProxy, isDmg, backPos = 0, "", false, false

---------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getCreature()
--> Description:    Get creature monster or player on screen.
--> Class:          Self
--> Params:         None              
--> Return:         boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCreature()

    -- inside loop for all found creatures on multiple floors do:
    for i, c in pairs(Creature.iCreatures(7, false)) do

        -- when we can not find a friends and creature is not NPC.
        if not table.find(FRIENDS, c.name) and not Creature.isNpc(c) then
            
            -- return creature.    
            return true

        end        
        
    end

    -- return false noone player found.
    return false

end 

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getProxy(keywords, friends)
--> Description:    Search in error message proxy specific keyword.
--> Class:          None
--> Params:         
-->                 @keywords table of strings we search.
-->                 @friends table if our friends to avoid if we skill example.
--> Return:         string last proxy message if keyword found or empty string ""
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getProxy(keywords, friends)

    -- load last proxy msg
    local proxy = Proxy.ErrorGetLastMessage()

    -- in loop for key words
    for i = 1, #keywords do

        -- load single key
        local key = keywords[i]

        -- check if string is inside proxy
        if string.instr(proxy, key) then

            -- in loop check if string not contains our friends.
            for j = 1, #friends do

                -- load single friend.
                local friend = friends[j]

                -- check if attacking our friend.
                if string.instr(proxy, "attack by " .. friend) then

                    -- return empty string
                    return ""

                end    

            end

            -- return proxy.
            return proxy

        end
        
    end
    
    -- return empty string ""
    return ""        

end



Module.New("Step back on DMG taken", function ()
    
    -- load if we found proxy key
    local proxy = getProxy(KEY_WORDS, FRIENDS)

    -- load self pos.
    local selfPos = Self.Position()

    -- set var default false.
    local var, var2 = false, false

    -- when param contains true
    if IF_PUSHED_GO_TO_SAFE_POS then

        -- set var to check range.
        var = (selfPos.x ~= STEP_BACK.pos[1] and selfPos.x ~= STEP_POS[1]) or (selfPos.y ~= STEP_BACK.pos[2] and selfPos.y ~= STEP_POS[2])

    end

    -- when we check for creatures too.
    if IF_CREATURE_GO_TO_SAFE_POS then

        -- load creatures
        var2 = getCreature()

    end    

    -- if proxy is different than ""
    if proxy ~= "" or var or var2 then

        -- set param isDmg true
        isDmg = true

        -- if var set diff msg.
        if var then

            -- set msg about pushing.
            lastProxy = "You are pushed by some player."

        elseif var2 then
        
            -- set msg about creature.
            lastProxy = "Step back due creature."    

        else    
            
            -- store last proxy
            lastProxy = proxy

        end 

    end    

    -- if param isDmg contains true then we should step to house.
    if isDmg then

        -- load distane from step pos
        local dist = Self.DistanceFromPosition(STEP_POS[1], STEP_POS[2], STEP_POS[3])

        -- when distance is diff than 0
        if dist ~= 0 then

            -- wait time to avoid auto step this my by easy detectable as bot
            wait(800, 1500)

            -- load direction to step.
            local dir = Self.getDirectionFromPosition(STEP_POS[1], STEP_POS[2], STEP_POS[3], dist)

            -- step to safe pos
            Self.Step(dir)

            -- if you want to step into character in door use wait and step to go through.
            -- wait(200)
            -- Self.Step(dir)

        else

            -- we need to clear message.
            Proxy.ErrorClearMessage()

            -- set message to Rifbot console
            Rifbot.ConsoleWrite(lastProxy)

            -- set time we are in house.
            stepTime = os.time()

            -- set variable isDmg false
            isDmg = false

            -- set variable backPos true
            backPos = true

        end

    -- if no dmg taken or we are in house    
    else

        -- if backPos is enabled and not creatures.
        if backPos and not var2 then

            -- when time is valid.
            if os.time() - stepTime > (STEP_BACK.delay * 60) then

                local distance = Self.DistanceFromPosition(STEP_BACK.pos[1], STEP_BACK.pos[2], STEP_BACK.pos[3])

                -- when our position is different than currentPos or we dont enabled step back.
                if distance > 0 then

                    -- load direction to step.
                    local dir = Self.getDirectionFromPosition(STEP_BACK.pos[1], STEP_BACK.pos[2], STEP_BACK.pos[3], distance)

                    -- step to this direction.
                    Self.Step(dir)

                    -- You can also use alana sio to tp yourself.
                    Self.Say("alana sio")

                    -- wait some time to avoid over dashing.
                    wait(500, 1000)

                -- our position is this same as we stay before
                else
                    
                    -- set message to console.
                    printf("Successfully return to position due a DMG taken.")

                    -- reset time
                    stepTime = 0

                    -- set backPos false
                    backPos = false

                end

            else
            
                -- When step back is enabled.
                if STEP_BACK.enabled then

                    -- show message time to back
                    printf(lastProxy .. " Back within " .. STEP_BACK.delay .. " minutes")

                    -- load distance to pos.
                    local distance = Self.DistanceFromPosition(STEP_BACK.pos[1], STEP_BACK.pos[2], STEP_BACK.pos[3])

                    -- when dostance is equal 0 we back to pos.
                    if distance == 0 then  
                        
                        -- set message to console.
                        printf("Successfully return to position due a " .. lastProxy)

                        -- reset time
                        stepTime = 0

                        -- set backPos false
                        backPos = false

                    end    

                else
                    
                    -- show message back is disabled
                    printf(lastProxy .. " Step back is disabled.")

                    -- reset time we dont want to back.
                    stepTime = 0
                    
                    -- when logout enabled.
                    if STEP_BACK.logout then
                        
                       -- if no pz flag
                       if not Self.isInFight() then
                                
                            -- logout.
                            Self.Logout()
                            
                           -- set backPos false
                           backPos = false        
                                
                       end         
                     
                    else
                          
                       -- set backPos false
                       backPos = false        
                            
                    end 

                end
                    
            end

        end    

    end 

end)
