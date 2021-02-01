--[[
    Script Name: 		Logout if no balnks in bps
    Description: 		When no more blanks in containers then disable runemaker and logout character.
 
    Author: 			Ascer - example
]]

local BLANK_RUNE_ID = 2260		-- ID of blank rune.


-- DON'T EDIT BELOW THIS LINE



-- Module to run function in loop.
Module.New("Logout if no balnks in bps", function()

	-- when connected.
	if Self.isConnected() then

		-- check for blanks in backpacks
		if Self.ItemCount(BLANK_RUNE_ID) <= 0 then

			-- check for hands
			if Self.Shield().id ~= BLANK_RUNE_ID and Self.Weapon().id ~= BLANK_RUNE_ID then

				-- disable Runemaker.
				Rifbot.setCheckboxState("runemaker", "enabled", false)

				-- logout
				Self.Logout()

			end	

		end	
		
	end	

end)