--[[
    Script Name:        Conjure Arrows
    Description:        Create Arrows with conditions meets.
    Author:             Ascer - example
]]

local SPELL = {name = "exevo con", mana = 400}		-- name -> spell to cast, mana -> min mana to cast spell
local ITEM = {id = 3447, amount = 100, cap = 50}	-- id -> id of arrows, amount -> create only when below this amount, cap -> dont create when cap below.
local MONSTERS = {enabled = false, safe = {"rat", "snake"}}  -- don't create when monsters on sceen enabled - true false, safe list, enter names.

-- DON'T EDIT BELOW THIS LINE

MONSTERS.safe = table.lower(MONSTERS.safe)

function isMob()
	if not MONSTERS.enabled then return false end
	for _, c in ipairs(Creature.iMonsters(7, false)) do
		if not table.find(MONSTERS.safe, string.lower(c.name)) then
			return true
		end	 
	end
	return false	
end	--> returns true or false if is monster on screen (safe list reading)

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

					-- when no mobs
					if not isMob() then

						-- cast Spell.
						Self.Say(SPELL.name)

					end	

				end

			end	

		end	

	end	

	-- module daly
	mod:Delay(500, 800)

end)
