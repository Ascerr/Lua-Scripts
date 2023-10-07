--[[
    Script Name: 		Alarm On Mana
    Description: 		Play sound if your mana points are below or above MANA value.
    Author: 			Ascer - example
]]

local config = {
	mana = 150,				-- mana points value to active alarm if it will below or equal or above.
	typeOf = "below",		-- type of mana to check possible are: "below", "equal", "above", "below-equal", "above-equal"
	pauseBot = false		-- true/false pause bot with lua scripts.
}

-- DON'T EDIT BELOW THIS LINE
config.typeOf = string.lower(config.typeOf)

-- module run function inside loop
Module.New("Alarm On Mana", function ()
	if Self.isConnected() then
		local mp = Self.Mana()
		local cond = false
		if config.typeOf == "below" then
			cond = mp < config.mana
		elseif config.typeOf == "below-equal" then
			cond = mp <= config.mana	
		elseif config.typeOf == "equal" then
			cond = mp == config.mana
		elseif config.typeOf == "above" then
			cond = mp > config.mana
		elseif config.typeOf == "above-equal" then
			cond = mp >= config.mana			
		end
		if cond then
			Rifbot.PlaySound()
			if config.pauseBot then
				Rifbot.setEnabled(false, true)
			end	
			print("Detected mana " .. config.typeOf .. " " .. config.mana .. " points.")
		end	
	end		
end)
