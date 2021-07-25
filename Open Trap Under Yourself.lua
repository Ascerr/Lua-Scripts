--[[
    Script Name:        Open Trap Under Yourself
    Description:        Use map to open trap under your character.
    Author:             Ascer - example
]]


local CLOSED_TRAP_ID = 2920        -- id of closed trap
local USE_DELAY = 500              -- delay between use

-- DONT EDIT BELOW THIS LINE

-- module run func in loop.
Module.New("Open Trap Under Yourself", function ()

    -- when connected.
    if Self.isConnected() then

        -- load self pos.
        local self = Self.Position()

        -- load map around you.
        local map = Map.GetTopMoveItem(self.x, self.y, self.z)

            -- when closed trap found
        if map.id == CLOSED_TRAP_ID then

                -- use item on map.
            return Map.UseItem(self.x, self.y, self.z, CLOSED_TRAP_ID, map.stack, USE_DELAY)

        end


    end    

end)
