--[[
    Script Name:        Skinning Creatures.
    Description:        Using skinning item with dead cropse of monsters.
    Author:             Ascer - example
]]

local ITEM = 5942                        -- item we using on creature like obsidian life, wooden stake 5908 = obsidian knife 5942 = wooden stake
local CROPSES = {4272, 4057, 4011, 4137}      -- cropses of monsters on ground. !Remember on 8.0 servers cropse due time change their id and you should set second id this after ~5s.
local MAX_ATTEMPTS = 8                  -- max attempts to skin creature. 
local RANGE = {x = 5, y = 4}            -- range for skinning on map.
local CLEAR_IGNORE_LIST_EVERY = 5       -- every this time in minutes will be cleared ignore list with cropses.
local ENABLE_DISABLE_WALKER = true      -- true/false control walker when attemping for skinnig.
local USE_TOOL_DELAY = 800              -- use tool every this time in miliseconds..

-- DONT EDIT BELOW THIS LINE

local currCropse, tries = {x = -1, y = -1, z = -1, id = -1}, 0
local ignored = {}

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getCropse()
--> Description:    Read for current cropse on map.

--> Return:         table with cropse or -1 if not found.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCropse()

    -- load self pos
    local pos = Self.Position()

    -- when currCropse id diff than -1
    if currCropse.id ~= -1 then

        -- return currCropse
        return currCropse

    end    

    -- inside loop
    for x = -RANGE.x, RANGE.x do
        
        for y = -RANGE.y, RANGE.y do

            -- load map area.
            local map = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)

            -- when we find cropse
            if table.find(CROPSES, map.id) then

                -- set continue on true
                local continue = true

                -- for ignored cropses
                for i, c in ipairs(ignored) do

                    -- when position is this same
                    if c.x == pos.x + x and c.y == pos.y + y and c.z == pos.z then

                        -- set continue false
                        continue = false

                        -- break loop
                        break

                    end    

                end    

                -- when continue is false
                if continue then

                    -- reset tries
                    tries = 0

                    -- set
                    currCropse = {x =pos.x + x, y =pos.y + y, z = pos.z, id = map.id} 

                    -- return cropse
                    return currCropse

                end    

            end   

        end
        
    end        

    -- return -1 there is no cropse
    return -1

end 



-- loop module
Module.New("Skinning Creatures", function (a)

    -- when connected to game
    if Self.isConnected() then

        -- do actions only if no looting and targeting.
        if Self.TargetID() <= 0 and not Looter.isLooting() then

            -- get cropse
            local cropse = getCropse()

            -- when cropse if valid.
            if cropse ~= -1 then

                -- when enabled.
                if ENABLE_DISABLE_WALKER and Walker.isEnabled() then

                    -- disable walker
                    Walker.Enabled(false)

                end    

                -- when tries still left
                if tries < MAX_ATTEMPTS then

                    -- load current id of this tile
                    local map = Map.GetTopMoveItem(cropse.x, cropse.y, cropse.z)

                    -- when id is this same as at start
                    if map.id == cropse.id then

                        -- load self pos
                        local pos = Self.Position()

                        -- when pososition is this same as my position
                        if cropse.x == pos.x and cropse.y == pos.y and cropse.z == pos.z then

                            -- enable walker for a few seconds
                            Walker.Enabled(true)

                            -- wait some time.
                            wait(2000)

                        end    
                        

                        -- use item with ground
                        local ret = Self.UseItemWithGround(ITEM, cropse.x, cropse.y, cropse.z, USE_TOOL_DELAY)

                        -- when ret is true add tries.
                        if ret then

                            -- add tries
                            tries = tries + 1

                        end

                    else
                        
                        -- reset cropse
                        currCropse = {x = -1, y = -1, z = -1, id = -1}

                        -- when not enabled.
                        if ENABLE_DISABLE_WALKER and not Walker.isEnabled() then

                            -- enable walker
                            Walker.Enabled(true)

                        end    

                    end        

                else

                    -- reset cropse
                    currCropse = {x = -1, y = -1, z = -1, id = -1}

                    -- add cropse to ignore list.
                    table.insert(ignored, cropse)

                    -- when not enabled.
                    if ENABLE_DISABLE_WALKER and not Walker.isEnabled() then

                        -- enable walker
                        Walker.Enabled(true)

                    end    

                    -- show info
                    print("Ignore skinning cropse " .. cropse.id .. " due max tries.")

                end       
                
            end    

        end
            
    end    

    -- delay between actions in miliseconds
    a:Delay(200, 500)

end)

Module.New("Clear ignore list", function(b)
    -- clear ignore list
    ignored = {}
    b:Delay(60000 * CLEAR_IGNORE_LIST_EVERY)
end)
