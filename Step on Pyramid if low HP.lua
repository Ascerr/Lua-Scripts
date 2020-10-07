--[[
    Script Name: 		Step on Pyramid if low HP
    Description: 		If Health percent of character will bellow examle 50% then char will try to step on pyramid.
    Author: 			Ascer - example
]]

local POSSIBLE_STEP_LOCATIONS = {		-- where character could step.
	{x = 32095, y = 32216, z = 7},
	{x = 32096, y = 32216, z = 7},
	{x = 32097, y = 32216, z = 7}
}

local WHEN_HPPERC_BELOW = 90			-- step if health percent below x.


-- DON'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		isSafe()
--> Description: 	Read if self character is on safe pos.
--> Class: 			None
--> Params:			@pos - table with positions.
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function isSafe(pos)

	-- load self pos.
	local me = Self.Position()

	-- check if we already on safe pos.
	for i, ground in ipairs(pos) do
		
		-- when our pos is this same return.
		if ground.x == me.x and ground.y == me.y and ground.z == me.z then

			-- ret true my pos is valid.
			return true

		end	

	end

	-- ret false my pos is diff.
	return false

end	




Module.New("Step on Pyramind if low HP", function(mod)

	-- when self connected.
	if Self.isConnected() then

		-- load self hpperc.
		local hpperc = Self.HealthPercent()

		-- when low hp
		if hpperc < WHEN_HPPERC_BELOW then

			-- check if still far from safe pos.
			if not isSafe(POSSIBLE_STEP_LOCATIONS) then

				-- get random pos to step.
				local randPos = math.random(1, table.count(POSSIBLE_STEP_LOCATIONS))

				-- Step there.
				Self.Step(Self.getDirectionFromPosition(POSSIBLE_STEP_LOCATIONS[randPos].x, POSSIBLE_STEP_LOCATIONS[randPos].y, POSSIBLE_STEP_LOCATIONS[randPos].z, Self.DistanceFromPosition(POSSIBLE_STEP_LOCATIONS[randPos].x, POSSIBLE_STEP_LOCATIONS[randPos].y, POSSIBLE_STEP_LOCATIONS[randPos].z)))

			end	

		end	

	end

	-- delay
	mod:Delay(200, 400)

end)