--[[
    Script Name: 		Drink MF depent on Friend Hpperc
    Description: 		Drink mana fluids up to 90% until friend hpperc drop down then heal him with uh.
    Author: 			Ascer - example
]]

local MANA_PERCENT = 90						-- drink mf up to this percent of mana your chatacter
local FRIEND_HEALTH_PERCENT = 70 			-- when friend hpperc will below then use uh with him.
local SELF_MINIMAL_HPPERC_TO_USE = 50		-- when your character hpperc will below then script will health you with uh.
local MF = {id = 2874, delay = 1000}		-- id of mana fluid to use
local UH = {id = 3160, delay = 1000}		-- id of heal rune to use
local FRIENDS = {"Friend1", "Friend2"}		-- list of friends to check.

-- DON'T EDIT BELOW THIS LINE

FRIENDS = table.lower(FRIENDS)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getFriends(list)
--> Description: 	Read for friend with low health.
--> Params:			
-->					@list - table of players we search
--> Return: 		table with player or nill
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getFriends(list)
	for i, player in pairs(Creature.iPlayers(7, false)) do
		if table.find(list, string.lower(player.name)) and player.hpperc <= FRIEND_HEALTH_PERCENT then
			return player
        end
    end
    return -1
end

-- module run in loop
Module.New("Drink MF depent on Friend Hpperc", function ()

	-- when self hpperc will below then use rune with you.
	if Self.HealthPercent() < SELF_MINIMAL_HPPERC_TO_USE then

		-- use item with your character.
		Self.UseItemWithMe(UH.id, UH.delay)

	else
		
		-- load player.
		local player = getFriends(FRIENDS)

		-- check if there is any friend with low hp.
		if player ~= -1 then

			-- Use item with him.
			Self.UseItemWithCreature(player, UH.id, UH.delay)

		else	

			-- check for your character mana and use mf.
			if Self.ManaPercent() < MANA_PERCENT then

				-- use mf with you.
				Self.UseItemWithMe(MF.id, MF.delay)

			end	

		end	

	end	

end)
