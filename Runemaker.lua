--[[
    Script Name:        Runemaker
    Description:        Making runes or cast spell in game. Checking for no blank runes. Wear balnk if need, put back created rune to bp.
    Author:             Ascer - example
]]

local MAIN_DELAY = {400, 1700} 						-- delay in milisecond random actions
local MANA_ABOVE = 120								-- MANA POINTS above this cast spell
local SPELL = "adori" 								-- spell to cast
local WEAR_BLANKS = {enabled = false, id = 3147}	-- wear blanks @enabled = true/false, @id = id of blank rune default 3147
local CAST_ON_TIME = {enabled = false, sec = 80}	-- cast spell every x seconds, @enabled - true/false, @sec - amount of seconds
local DONT_CAST_IF_PLAYER = false					-- don't cast it other player not from friends list on screen.

local NO_BLANKS = { 								-- when no blank runes:
	castSpell = true, 								-- cast spell: true/false
	spell = "exura", 								-- spell to cast 
	logout = false, 								-- logout true/false
	keyword = "magic item to cast",					-- check for this keyword white message when no blanks.
	delay = 20										-- cast spell every this delay in sec only if CAST_ON_TIME.enabled = true
}

-- DONT'T EDIT BELOW THIS LINE

local castTime, castNoBlanksSpellTime, lastblank, friends = 0, 0, 0, Rifbot.FriendsList(true)

function getPlayer()
    if not DONT_CAST_IF_PLAYER then return false end
    for i, c in ipairs(Creature.iPlayers(7, false)) do
        if not table.find(friends, string.lower(c.name)) then
            return true
        end
    end
    return false    
end  

Module.New("Runemaker", function (mod)
	if Self.isConnected() then
		if not getPlayer() then
			if Self.Mana() >= MANA_ABOVE then
				if not CAST_ON_TIME.enabled or (os.clock() - castTime > CAST_ON_TIME.sec) then
					if string.instr(Proxy.ErrorGetLastMessage(), NO_BLANKS.keyword) then
						if NO_BLANKS.logout then
							Self.Logout()
							Rifbot.ConsoleWrite("[" .. os.date("%X") .. "] logged due a no more blank runes") -- set message to Rifbot Console.
						else
							if NO_BLANKS.castSpell then
								if not CAST_ON_TIME.enabled or (os.clock() - castNoBlanksSpellTime >= NO_BLANKS.delay) then
									Self.CastSpell(NO_BLANKS.spell)
									castNoBlanksSpellTime = os.clock()
								end
							end
						end
						Proxy.ErrorClearMessage() -- we need to clear message manually.		
					else
						if WEAR_BLANKS.enabled then
							local weapon = Self.Weapon().id
							if weapon == WEAR_BLANKS.id then
								Self.CastSpell(SPELL, 0, math.random(2000, 3000))
								castTime = os.clock()
							else
								local blank = Container.FindItem(WEAR_BLANKS.id)
								if table.count(blank) > 0 then
									Container.MoveItemToEquipment(blank.index, blank.slot, SLOT_WEAPON, WEAR_BLANKS.id, 1)
									lastblank = blank
								else	
									if not CAST_ON_TIME.enabled or (os.clock() - castNoBlanksSpellTime >= NO_BLANKS.delay) then
										Self.CastSpell(NO_BLANKS.spell, 20, math.random(2000, 3000))
										castNoBlanksSpellTime = os.clock()
									end	
								end	
							end	
						else	
							Self.CastSpell(SPELL, 20, math.random(2000, 3000))
							castTime = os.clock()
						end	
					end
				end
			else					
				if WEAR_BLANKS.enabled then	
					local weapon = Self.Weapon().id
					if not table.find({0, WEAR_BLANKS.id}, weapon) then
						if table.count(lastblank) >= 0 then
							Self.DequipItem(SLOT_WEAPON, lastblank.index, 0) --> put back rune to saved backpack.
						else
							Self.DequipItem(SLOT_WEAPON) --> put back rune to any backpack.
						end	
					else	
						lastblank = 0		
					end	
				end	
			end
		end
	end					
	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2]) -- set random delay
end)

