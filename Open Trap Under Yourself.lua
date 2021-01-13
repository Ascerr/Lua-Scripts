--[[
    Script Name:        Open Trap Under Yourself
    Description:        Use map to open trap under your character.
    Author:             Ascer - example
]]


local CLOSED_TRAP_ID = 2920         -- id of closed trap
local USE_DELAY = 500              -- delay between use
local ITEM_STACK = 2                -- stack of item on ground (most of time 2 or 3)


-- DONT EDIT BELOW THIS LINE


-- module run func in loop.
Module.New("Open Trap Under Yourself", function ()

    -- when connected.
    if Self.isConnected() then

        -- load map around you.
        local map = Map.getArea(1)

        -- load self pos.
        local self = Self.Position()

        -- inside loop check for self pos.
        for i, square in pairs(map) do
            
            -- when square is equal to your pos
            if square.x == self.x and square.y == self.y and square.z == self.z then
                
                -- when closed trap found
                if Map.SquareContainsItem(square.items, CLOSED_TRAP_ID) then

                    -- use item on map.
                    return Map.UseItem(self.x, self.y, self.z, CLOSED_TRAP_ID, ITEM_STACK, USE_DELAY)

                end
                    
            end
        end

    end    

end)