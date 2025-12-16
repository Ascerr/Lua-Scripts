--[[
    Script Name:        Convert chests to monsters
    Description:        When you found specific ids of chest on map {15x11 sqms only} then click them. Will ignore action if you targeting some creature
    Author:             Ascer - example
]]

local CHESTS = {3031, 3492, 3160}                       -- IDs of chest on map area
local DISABLE_WALKER = true                             -- true/false disale walker when chest found


-- DON'T EDIT BELOW

Module.New("Convert chests to monsters", function ()
    if Self.isConnected() and Self.TargetID() <= 0 then
        local pos = Self.Position()
        for x = -7, 7 do
            for y = -5 , 5 do
                local map = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)
                if table.find(CHESTS, map.id) then
                    if DISABLE_WALKER then
                        if Walker.isEnabled() then Walker.Enabled(false) end
                    end   
                    return Map.UseItem(pos.x + x, pos.y + y, pos.z, map.id, 1, 2000) -- use chests with 2 s delay
                end 
            end
        end
        if DISABLE_WALKER then
            if not Walker.isEnabled() then Walker.Enabled(true) end  
        end       
    end
    mod:Delay(500)
end) 