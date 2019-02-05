--[[
    Script Name: 		Step back on DMG taken
    Description: 		Step to ground x, y, z when any dmg taken.
    Author: 			Ascer - example
]]

local STEP_POS = {32339, 32226, 8}
local KEY_WORDS = {"You lose"} -- set keyword for activate


Module.New("Step back on DMG taken", function (mod)
    local proxy = Proxy.ErrorGetLastMessage()
    for i = 1, #KEY_WORDS do
        local key = KEY_WORDS[i]
        if string.instr(proxy, key) then
            if Self.DistanceFromPosition(STEP_POS[1], STEP_POS[2], STEP_POS[3]) ~= 0 then
                Self.Step(Self.getDirectionFromPosition(STEP_POS[1], STEP_POS[2], STEP_POS[3]))
                break
            else
                Proxy.ErrorClearMessage() -- we need to clear message.
                Rifbot.ConsoleWrite(proxy)
            end
        end
    end
    mod:Delay(200, 500)
end)
