--[[
    Script Name: 		Heal Friends
    Description: 		Heal friends and/or party members with exura sio or uh. Required Rifbot v1.31
    Author: 			Ascer - example
]]

local MAIN_DELAY = {400, 1200}				-- time in miliseconds between reading main loop
local UHID = 3160							-- ultimate healing rune id
local HEAL_PARTY = true						-- heal party members true/false 
local FRIENDS = {"friend1", "friend2"} 		-- list of friends
local HEALTH_PERCENT = 60					-- heal below 60% hp.
local HEAL_WITH_UHS = true					-- heal with uh rune
local HEAL_WITH_SIO = true					-- heal with exura sio, when HEAL_WITH_UHS = true and uhs not found use sio.

-- DON'T EDIT BELOW THIS LINE

FRIENDS = table.lower(FRIENDS) -- convert table to lower strings.

Module.New("Heal Friends", function (mod)
	for i, player in pairs(Creature.iPlayers(7, false)) do  -- get only players on screen
		local var = (HEAL_PARTY and (Creature.isPartyMember(player) or Creature.isPartyLeader(player))) or table.find(FRIENDS, string.lower(player.name))
		if var and player.hpperc < HEALTH_PERCENT then
			if HEAL_WITH_UHS then
				local item = Container.FindItem(UHID)
				if not item then
					if HEAL_WITH_SIO then
						Self.CastSpell("exura sio \"" .. player.name, 60) -- cast exura sio when no uhs found.
					end
				else
					Container.UseItemWithCreature(item.index, item.slot, item.id, player, math.random(1500, 2200)) -- use uh
				end
			elseif HEAL_WITH_SIO then
				Self.CastSpell("exura sio \"" .. player.name, 60) -- cast exura sio when no uhs found.
			end
			break -- end loop
		end
	end								
	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2])					
end)
