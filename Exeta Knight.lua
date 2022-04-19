--[[
    Script Name:        Exeta Knight
    Description:       	Use exeta res when monsters and hp > x%
    Author:             Ascer - example
]]

local MONSTERS_AMOUNT = 1		-- use only if monsters around (1sqm) will >= this value
local MIN_SELF_HPPERC = 70		-- use inly if hpperc your character >= this value
local SPELL = {name = "exeta res", mana = 30, delay = 5000} -- spell name, spell min mana, spell delay (time in miliseconds between usage).


--  DON'T EDIT BELOW THIS LINE

local castTime = 0

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getMonstersAround(range)
--> Description: 	Return amout of monsters around you.
--> Params:		
-->					@range - number distance from your character
--> Return: 		number amount of monster
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getMonstersAround(range)
	local mobs = Creature.iMonsters(range, false)
    local count = 0
    for i = 1, #mobs do
        count = count + 1
    end
    return count
end

Module.New("Exeta Knight", function (mod)
	
	-- when connected.
	if Self.isConnected() then

		-- load hp, mama
		local mp = Self.Mana()
		local hpperc = Self.HealthPercent()

		-- when mana and hpperc is ok
		if mp >= SPELL.mana and hpperc >= MIN_SELF_HPPERC and os.clock() - castTime >= (SPELL.delay/1000) then

			-- load monsters.
			local monsters = getMonstersAround(1)

			-- when monsters amount will ok
			if monsters >= MONSTERS_AMOUNT then

				-- cast spell
				Self.Say(SPELL.name)

				-- set time
				castTime = os.clock()

			end	

		end	

	end	
	
	-- delay
	mod:Delay(300, 500)

end)
