--[[
    Script Name: 		Random Move 1sqm
    Description: 		Move sqm to sqm (range 1)
    Author: 			Ascer - example
]]

local POS = {x = 32099, y = 32217, z = 7}			-- first position
local POS2 =  {x = 32099, y = 32216, z = 7}			-- second position
local DO_EVERY = 60000								-- do every milis (60000 = 1min)
local TRIES_STEP = 4								-- tries to move
local STEP_DELAY = 300								-- delay in miliseconds we can step 

-- DONT EDIT BELOW THIS LINE
local stepTime, timeExecution, tries = 0, 0, 0

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		delayedStep(dir)
--> Description: 	Get creature you already attack	
--> Params:			
-->
-->					@dir number direction to step
--> Return: 		none
----------------------------------------------------------------------------------------------------------------------------------------------------------
function delayedStep(dir)
	if os.clock() - stepTime > (STEP_DELAY / 1000) then
		Self.Step(dir)
		stepTime = os.clock()
		return true
	end	
	return false
end		


Module.New("Random Move 1sqm", function (mod)
	
	-- check if connected
	if Self.isConnected() and os.clock() - timeExecution > (DO_EVERY / 1000) then

		-- load self
		local self = Self.Position()

		-- check for pos and step.
		if Self.DistanceFromPosition(POS.x, POS.y, POS.x) > 0 then
			if delayedStep(Self.getDirectionFromPosition(POS.x, POS.y, POS.x)) then tries = tries + 1 end
		else
			if delayedStep(Self.getDirectionFromPosition(POS2.x, POS2.y, POS2.x)) then tries = tries + 1 end
		end	

		-- reset tries
		if tries > TRIES_STEP then
			tries = 0
			timeExecution = os.clock()
		end	

	end	

end)

