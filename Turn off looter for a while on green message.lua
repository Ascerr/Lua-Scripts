--[[
    Script Name:        Turn off looter for a while on green message
    Description:        When you botting on servers that send you green message with loot 
                        this script will turn off looter if loot message don't contain specific items.
                        if you killing monsters using area spell or runes it may failure.

    Required:           Rifbot version 2.39 release 2022-09-27 or later                               
    
    Author:             Ascer - example
]]

local config = {
    items = {"cheese", "worm"},     -- items accepted to DON'T turn off looter
    time = 200                                -- time in miliseconds how long looter will be disabled. (200ms = 0.2s it's short time but enough to disable opening not valuable cropses)
}

-- DON'T EDIT BELOW

local offLooter, offTime = false, 0 
config.items = table.lower(config.items)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       isItemInMessage(msg)
--> Description:    Check if in current msg there is some item to loot.
--> Params:         
-->                 @msg string to find
--> Return:         boolean true or false       
----------------------------------------------------------------------------------------------------------------------------------------------------------
function isItemInMessage(msg)
    for j = 1, #config.items do
        if string.find(msg, "%f[%a]" .. config.items[j] .. "%f[%A]") then
            return true
        end 
    end
    return false    
end 

-- proxy func
function proxy(messages) 
    for i, msg in ipairs(messages) do 
        if string.instr(msg.message, "Loot of") then
            if isItemInMessage(string.lower(msg.message)) then
                return true
            end
        end         
    end
    Looter.Enabled(false)
    offLooter = true
    offTime = os.clock() 
end
Proxy.TextNew("proxy")

-- loop here
Module.New("Turn off looter for a while on green message", function()

    -- when is enabled looter off
    if offLooter then

        -- if time is below setted.
        if (os.clock() - offTime) * 1000 < config.time then 

            -- disable looter when enabled
            if Looter.isEnabled() then Looter.Enabled(false) end

        else
            
            -- enable looter
            if not Looter.isEnabled() then 

                Looter.Enabled(true) 

            else    

                -- disable param
                offLooter = false
            end

        end    

    end 

end)
