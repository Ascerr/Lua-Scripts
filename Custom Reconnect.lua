--[[
    Script Name:        Custom Reconnect
    Description:        Reconnect to game using mouse and keyboard simulation.
    Author:             Ascer - example
]]

local ENTER_GAME_POS = {x = 120, y = 500} -- position x, y of enter game button on game window


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		customReconnect(x, y)
--> Description: 	Reconnect to game using mouse and keyboard simulation 
--> Class: 			Rifbot
--> Params:
-->					@x - number position x to click Enter Game button.
-->					@y - number position y to click Enter Game button
-->					@side - number 0 = left mouse, 1 = right mouse.
--> Return: 		boolean true or false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function customReconnect(x, y)
	
	if not Self.isConnected() then

		-- press key esc.
		Rifbot.PressKey(27)

		wait(1000)

		-- click mouse to enter game
		Rifbot.MouseClick(x, y)

		wait(1000)

		-- in loop use enters.
		for i = 1, 5 do
			
			-- press enter
			Rifbot.PressKey(13)

			-- wait rando time
			wait(2000, 3000)

			if Self.isConnected() then

				-- return true we successfuly reconnected.
				return true

			end	

		end

	else

		-- return true we successfuly reconnected.
		return true

	end	

end



Module.New("Custom Reconnect", function ()
	
	customReconnect(ENTER_GAME_POS.x, ENTER_GAME_POS.y)

end)