--[[
    Script Name: 		Magic Wall front of target
    Description: 		Shoot magic wall rune front of target.
    Author: 			Ascer - example
]]
    
local MW_ID = 3180          -- id of magic wall rune

-- DONT EDIT BELOW THIS LINE

-- load target
local target = Self.TargetID()

-- when we have target.
if target > 0 then

    -- load creature
    target = Creature.getCreatures(target)

    -- when successfully load creature
    if table.count(target) > 1 then

        -- get creature direction.
        local dir = target.direction

        -- set additional pos
        local x, y = 0, 0

        -- set position of target by dir.
        if dir == 0 then
            y = -1
        elseif dir == 1 then
            x = 1
        elseif dir == 2 then
            y = 1
        elseif dir == 3 then
            x = -1
        end                
            
        -- throw magic wall
        Self.UseItemWithGround(MW_ID, target.x + x, target.y + y, target.z, 1000)

    end    
    
end        