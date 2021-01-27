--[[
    Script Name: 		Enable Cavebot if no Blanks
    Description: 		When no blank runes found enable cavebot
    Author: 			Ascer - example
]]

local BLANK_ID = 2260	-- type here id of balnk rune


-- DON'T EDIT BELOW THIS LINE

Module.New("Enable Cavebot if no Blanks", function (mod)
		
	-- when connected
	if Self.isConnected() then

		-- if no balnks
		if Self.ItemCount(BLANK_ID) <= 0 then

			-- when no enabled
			if not Walker.isEnabled() then 

				Walker.Enabled(true)

			end	
				
		end 

	end	

	-- delay
	mod:Delay(500)

end)
