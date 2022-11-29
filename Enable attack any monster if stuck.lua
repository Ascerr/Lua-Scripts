--[[
    Script Name:        Enable attack any monster if stuck
    Description:        When walker stuck enable attack any monster else disable.
    Author:             Ascer - example
]]

-- DON'T EDIT BELOW

Module.New("Enable attack any monster if stuck", function()
    local enable = false
    if Walker.isStuck() then
        enable = true
    end    
    Rifbot.setCheckboxState("cavebot", "attack any monster", enable)   
end)