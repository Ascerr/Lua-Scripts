--[[
    Script Name:        Conjure Arrows
    Description:        Create Arrows with conditions meets.
    Author:             Ascer - example
]]

local SPELL = {name = "exevo con", mana = 40}		-- name -> spell to cast, mana -> min mana to cast spell
local ITEM = {id = 3447, amount = 100, cap = 50}	-- id -> id of arrows, amount -> create only when below this amount, cap -> dont create when cap below.

-- DON'T EDIT BELOW THIS LINE

Module.New("Conjure Arrows", function (mod)
	
	-- when Connected.
	if Self.isConnected() then

		-- load cap 
		local cap = Self.Capity()

		-- when above limit.
		if cap > ITEM.cap then

			-- load amount (read bps + arrow slot.)
			local amount = Self.ItemCount(ITEM.id) + Self.Ammo().count

			-- when amount will below limit.
			if amount < ITEM.amount then

				-- check mana.
				if Self.Mana() >= SPELL.mana then

					-- cast Spell.
					Self.Say(SPELL.name)

				end

			end	

		end	

	end	

	-- module daly
	mod:Delay(1000, 1500)

end)