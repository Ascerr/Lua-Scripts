--[[
    Script Name:        [on Shortkey] On Off Cavebot
    Description:       	Enable or disable whole cavebot module, its shortkey usage script type: EXECUTE name
    Author:             Ascer - example
]]


-- When cavebot is enabled disable it.
if Cavebot.isEnabled() then 
	
	-- disable
	Cavebot.Enabled(false)

else
	
	-- enable
	Cavebot.Enabled(true)

end	