--[[
    Script Name:        Say word once after login
    Description:        When you lost connection character will auto say command
    Author:             Ascer - example
]]

local config = {
	command = "train",				-- keyword to say after login to game.
	delay = 1000					-- how many miliseconds to wait after login to say word (delay 1000ms = 1sec)
}

-- DON'T EDIT BELOW THIS LINE
local train = false

Module.New("Say word once after login", function()
	if Self.isConnected() then
		if train then
			train = false
			wait(config.delay)
			Self.Say(config.command)
		end	
	else
		train = true	
	end	
end)