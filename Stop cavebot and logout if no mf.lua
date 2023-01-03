--[[
    Script Name:        Stop cavebot and logout is no mf
    Description:        This script will check for green message about using vials. If low amount then will stop cavebot and wait for lost pz to logout. 
    Required:			Gameclient need to send green message about vials.
    Author:             Ascer - example
]]

local config = {
	vialMsg = "Using one of (.+) vials...",			-- msg about vials, (.+) -> is place for detecting vials number
	amount = 10										-- when mfs below this amount do action.
}

-- DON'T EDIT BELOW THIS LINE
local currentVials, logout = -1, false

--> read special messages in game
function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        local vials = string.match(msg.message, config.vialMsg)
        if vials ~= nil then
            currentVials = tonumber(vials)
        end
    end 
end 
Proxy.TextNew("proxyText") 

Module.New("Stop cavebot and logout is no mf", function()
	if Self.isConnected() then
		if logout then
			if Walker.isEnabled() then Walker.Enabled(false) end
			if Looter.isEnabled() then Looter.Enabled(false) end
			if not Self.isInFight() then
				Self.Logout()
			else	
				print("Waiting for pz lost to logout..")
			end	
		end	
		if currentVials ~= -1 and currentVials <= config.amount then
			logout = true
		end
	else
		if logout then
			Rifbot.setCheckboxState("runemaker", "relogin after", false) -- disable here relogin from runemaker
		end		
	end	
end)  