--[[
    Script Name:        Logout if full mana
    Description:        Logout your character when full mana.
    Author:             Ascer - example
]]

-- DON'T EDIT BELOW

Module.New("Logout if full mana", function (mod)
	if Self.isConnected() then
		local mp = Self.Mana() 
		if mp > 0 and mp == Self.ManaMax() then
			Self.Logout()
		end	 
	end	
	mod:Delay(500, 1000)
end) 