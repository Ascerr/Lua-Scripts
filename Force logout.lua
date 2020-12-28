--[[
    Script Name:        Force logout
    Description:        Logout character when no pz. 
    Author:             Ascer - example
]]

Module.New("Force logout", function (mod)
	if Self.isConnected() then
		if not Self.isInFight() then
			Self.Logout()
		end
	end
	mod:Delay(200)		
end)