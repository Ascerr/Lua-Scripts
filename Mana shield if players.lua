--[[
    Script Name: 		Mana shield if players
    Description: 		Cast mana shield spell when player/s on screen. Avoid Friends.txt list from bot.
    Author: 			Ascer - example
]]

local PLAYERS_AMOUNT = 1										-- how many players on screen to cast utamo
local SPELL = {name = "utamo vita", mana = 50, delay = 500}		-- @name - spell to cast, @mana - min mana to use, @delay - cast every miliseconds.


-- DON'T EDIT BELOW THIS LINE

-- load friends form Friends.txt
local friends = Rifbot.FriendsList(true)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getPlayers()
--> Description: 	Check for players on screen.
--> Params:			None
-->				
--> Return: 		boolean true or false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPlayers()

	-- set count to start 0.
	local count = 0

	-- in loop check for monsters on screnn.
	for i, player in ipairs(Creature.iPlayers(7, false)) do
		
		-- when player is not in friend list.
		if not table.find(friends, string.lower(player.name)) then

			-- add count
			count = count + 1

		end

	end	

	-- return count players on screen
	return count

end

-- run in loop.
Module.New("Mana shield if players", function ()
	
	-- when connected.
	if Self.isConnected() then

		-- when players amount is good.
		if getPlayers() >= PLAYERS_AMOUNT then

			-- when no mana shielded.
			if not Self.isManaShielded() then

				-- when mana fine.
				if Self.Mana() >= SPELL.mana then

					-- cast spell.
					Self.CastSpell(SPELL.name, SPELL.mana, SPELL.delay)

				end	

			end	

		end	

	end	

end)
