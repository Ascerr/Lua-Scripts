-- Enable bot when you're under macro test.
-- Rifbot say code on time drop or risk detected.

Module.New("enableBotOnMacro", function (module)
	if Rifbot.isMacroMode() then
		setMacroMode(false)
	end	
	module:Delay(200)
end)