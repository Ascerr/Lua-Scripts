--[[
    Script Name: 		Step back on DMG taken 
    Description: 		Step to ground x, y, z when any dmg taken. // Edited: 2019-05-14, Added: step to position far than 1 sqm and back to previus pos after x minutes
    Author: 			Ascer - example
]]

local STEP_POS = {32080, 32182, 6}
local STEP_BACK = {enabled = true, pos = {32081, 32182, 6}, delay = 5}    -- return to previus position when will safe, @eabled - true/false, @pos - {x, y, z}, @delay - minutes

local KEY_WORDS = {"You lose"} -- set keyword for activate


-- DON'T EDIT BELOW THIS LINE

local stepTime, lastProxy = 0, ""


Module.New("Step back on DMG taken", function (mod)
    
    -- when time is equal to 0
    if stepTime == 0 then

        -- load last proxy msg
        local proxy = Proxy.ErrorGetLastMessage()

        -- in loop for key words
        for i = 1, #KEY_WORDS do

            -- load single key
            local key = KEY_WORDS[i]

            -- check if string is inside proxy
            if string.instr(proxy, key) then

                -- load distane from step pos
                local dist = Self.DistanceFromPosition(STEP_POS[1], STEP_POS[2], STEP_POS[3])

                -- when distance is diff than 0
                if dist ~= 0 then

                    -- load direction to step.
                    local dir = Self.getDirectionFromPosition(STEP_POS[1], STEP_POS[2], STEP_POS[3], dist)

                    -- step to safe pos
                    Self.Step(dir)

                    -- break loop
                    break

                else

                     -- we need to clear message.
                    Proxy.ErrorClearMessage()

                    -- set message to Rifbot console
                    Rifbot.ConsoleWrite(proxy)

                    -- store last proxy msg
                    lastProxy = proxy

                    -- set time we are in house.
                    stepTime = os.time()

                end

            end

        end

    else
        
        -- when time is valid.
        if os.time() - stepTime > (STEP_BACK.delay * 60) then

            local distance = Self.DistanceFromPosition(STEP_BACK.pos[1], STEP_BACK.pos[2], STEP_BACK.pos[3])

            -- when our position is different than currentPos.
            if distance > 0 then

                -- load direction to step.
                local dir = Self.getDirectionFromPosition(STEP_BACK.pos[1], STEP_BACK.pos[2], STEP_BACK.pos[3], distance)

                -- step to this direction.
                Self.Step(dir)

                -- wait some time to avoid over dashing.
                wait(500, 1000)

            -- our position is this same as we stay before
            else
                
                -- set message to console.
                printf("Successfully return to position due a DMG taken.")

                -- reset time
                stepTime = 0

            end

        else
        
            -- When step back is enabled.
            if STEP_BACK.enabled then

                -- show message time to back
                printf(lastProxy .. " Back within " .. STEP_BACK.delay .. " minutes")
                    
            else
               
                -- reset time we dont want to back.
                stepTime = 0 

            end
                
        end

    end 

    -- loop delay
    mod:Delay(200, 500)

end)
