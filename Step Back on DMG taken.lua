--[[
    Script Name: 		Step back on DMG taken 
    Description: 		Step to ground x, y, z when any dmg taken. // Edited: 2019-02-15, Added: step to position far than 1 sqm
    Author: 			Ascer - example
]]

local STEP_POS = {32339, 32226, 8}
local KEY_WORDS = {"You lose"} -- set keyword for activate


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getDirectionFromPosition(x, y, z)
--> Description:    Get direction from pos x, y, z.
--> Class:          Self        
--> Params:         
-->                 @x coordinate in the map on the x-axis
-->                 @y coordinate in the map on the y-axis
-->                 @z coordinate in the map on the z-axis
-->                 @range distance beteen position and your character.
--> Return:         number
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getDirectionFromPosition(x, y, z, range) 
    local self = Self.Position()
    if range == nil then
        range = 1
    end 
    if self.x == x and self.y - range == y then
        return 0
    elseif self.x + range == x and self.y == y then
        return 1
    elseif self.x == x and self.y + range == y then
        return 2
    elseif self.x - range == x and self.y == y then
        return 3
    elseif self.x + range == x and self.y - range == y then
        return 4
    elseif self.x + range == x and self.y + range == y then
        return 5
    elseif self.x - range == x and self.y + range == y then
        return 6
    elseif self.x - range == x and self.y - range == y then
        return 7
    else
        return 0
    end 
end

Module.New("Step back on DMG taken", function (mod)
    local proxy = Proxy.ErrorGetLastMessage()
    for i = 1, #KEY_WORDS do
        local key = KEY_WORDS[i]
        if string.instr(proxy, key) then
            local dist = Self.DistanceFromPosition(STEP_POS[1], STEP_POS[2], STEP_POS[3])
            if dist ~= 0 then
                Self.Step(getDirectionFromPosition(STEP_POS[1], STEP_POS[2], STEP_POS[3], dist))
                break
            else
                Proxy.ErrorClearMessage() -- we need to clear message.
                Rifbot.ConsoleWrite(proxy)
            end
        end
    end
    mod:Delay(200, 500)
end)
