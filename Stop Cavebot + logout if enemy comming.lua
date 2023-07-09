--[[
    Script Name: 		Stop Cavebot + logout if enemy comming
    Description: 		This lua will stop walking, keep targeting runned to allow kill monsters and logout when loose pz if you receive pm from your second character about enemies comming.
    Required:			Lua script for mc char that will be sent messages of players on screen, example this: https://github.com/Ascerr/Lua-Scripts/blob/master/PM%20With%20Players%20On%20Screen.lua
    Author: 			Ascer - example
]]

local config = {
	senders = {"MyMcChar1", "MyMcChar1"},		-- nicks of your characters stayed at road to exp and sending message about players
    enemies = {"Enemy1", "Enemy2"},				-- nicks of enemies that you want mark as danger and logout character before they come to screen and kill you
    relogin = {enabled = true, minutes = 0.5}	-- allow relogin afger
}

-- DON'T EDIT BELOW THIS LINE
local stopCavebot, logoutTime = false, 0

-- change enemies and senders to lower string
config.senders = table.lower(config.senders)
config.enemies = table.lower(config.enemies)

--> module side
Module.New("Stop Cavebot + logout if enemy comming", function()
	if Self.isConnected() then
		if stopCavebot then
			if Walker.isEnabled() then Walker.Enabled(false) end
			if Looter.isEnabled() then Looter.Enabled(false) end
			if not Self.isInFight() then
				Self.Logout()
				wait(1000)
			end	
		end	
	else
		if stopCavebot then
			logoutTime = os.clock()
			stopCavebot = false
			if not Walker.isEnabled() then Walker.Enabled(true) end
			if not Looter.isEnabled() then Looter.Enabled(true) end
		else	
			if config.relogin.enabled then
				if os.clock() - logoutTime >= (config.relogin.minutes * 60) then
					Rifbot.PressKey(13, 2000)  -- press enter key reconnect to game
				end	
			end	
		end	
	end	
end)


--> proxy side
function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if table.find(config.senders, string.lower(msg.speaker)) then
			for i = 1, #config.enemies do
				if string.instr(string.lower(msg.message), config.enemies[i]) then
					stopCavebot = true
					print("proxy message of enemy: " .. msg.speaker, msg.message, msg.channel, msg.mode, msg.level)
				end	
			end	
		end
	end 
end
Proxy.New("proxy")
