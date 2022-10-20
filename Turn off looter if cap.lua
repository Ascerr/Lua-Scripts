--[[
    Script Name:        Turn off looter if cap
    Description:        When capity will below x then turn off looter, else on.
    Author:             Ascer - example
]]

local config = {
    cap = {off = 50, on = 60}       -- [off] when cap <= disable looter, [on] when cap >= enable
}


-- DON'T EDIT BELOW THIS LINE
local offLooter = false

Module.New("Turn off looter if cap", function()

    -- when connected.
    if Self.isConnected() then

        -- load capity.
        local cap = Self.Capity()

        -- when low cap
        if cap <= config.cap.off then 

            -- when looter enabled->disable. 
            if Looter.isEnabled() then 
                Looter.Enabled(false) 
            else 
                offLooter = true    
            end

        else
            
            -- when cap is above and param offLooter is true.
            if cap >= config.cap.on and offLooter then

                -- enable looter
                if not Looter.isEnabled() then
                    Looter.Enabled(true) 
                else
                    offLooter = false 
                end    

            end    

        end    

    end    

end)
