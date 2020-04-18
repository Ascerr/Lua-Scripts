--[[
    Script Name:        On 99% Mana Cast Spell xTimes
    Description:       	When your mana reach 99% then cast spell example 4 times.
    Author:             Ascer - example
]]

local MANA_PERCENT = 99		-- cast spell when mana percent reach this %.
local CAST_TIMES = 4		-- cast spell x times.
local SPELL = "exura"		-- spell name

-- DON'T EDIT BELOW THIS LINE.

Module.New("On 99% Mana Cast Spell xTimes", function (mod)
	
	-- when we are connected.
	if Self.isConnected() then

		-- When self mana is near on target.
		if Self.ManaPercent() >= MANA_PERCENT then

			-- inside loop cast spell.
			for i = 1, CAST_TIMES do

				-- cast spell.
				Self.CastSpell(SPELL)

				-- wait ~2-3s
				wait(2200, 3000)

			end	

		end	

	end	

	-- set random delay
	mod:Delay(300, 1200)

end)