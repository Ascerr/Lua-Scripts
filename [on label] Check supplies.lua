--[[
    Script Name:        [on label] Check Supplies
    Description:        It's lua side where you will do actions on label.
    Author:             Ascer - example
]]


-- DONT EDIT BELOW THIS LINE

-- set params for start count
local refill = false

--> read label messages
function signal(label)
    if label == "check" then
        -- here check for supplies
        if Self.ItemCount(3031) >= 1000 then
            -- set true refil
            refil = true
        end    
    elseif label == "hunt" then    
        Walker.Goto("back")
    end    
end
Walker.onLabel("signal")