--[[
    Script Name:        Medivia Random Rune Make
    Description:       	When your mana reach 90% then cast spell example 4 times.
    Author:             Ascer - example
]]

local SCRIPT_DELAY = {300, 1200}		-- run script in this delay
local MANA_PERCENT = 90					-- cast spell when mana percent reach this %.
local BLANKID = 2260					-- id of blank rune
local CAST_TIMES = {3, 5}				-- cast spell random times.
local SPELL = "encuro vita"				-- spell name
local WHEN_PALYER_DONT_DO_THIS = false	-- when player appear on screen don't cast spell
local FRIENDS = {"Friend1", "Friend2"}  -- ignore this names (Capital letter)
local ANTI_GM_MANA_CHARGE = {			-- don't create runes when gm charge your mana (mana level change fast),
	enabled = true, 					-- true/false
	wait_min = 10						-- time in minutes character wait until continue runemaking 
}    

-- DON'T EDIT BELOW THIS LINE.
local rand, lastMana = math.random(CAST_TIMES[1], CAST_TIMES[2]), -1
local chargedTime = 0

---------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getPlayer()
--> Description:    Get player on screen
--> Params:         None              
--> Return:         boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getPlayer()

    -- inside loop for all found creatures on multiple floors do:
    for i, c in pairs(Creature.iPlayers(7, false)) do

        -- when we can not find a friends.
        if not table.find(FRIENDS, player.name) then
            
            -- return creature.    
            return true

        end        
        
    end

    -- return false noone player found.
    return false

end 


---------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getManaRegen()
--> Description:    Read mana gained since last period of time.
--> Params:         None              
--> Return:         number amount gained.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getManaRegen()

	-- load self mana
	local mana = Self.Mana()

	-- calculate gained mana since last time.
	local gainedMana = mana - lastMana

	-- when lastMana will below 0 then set 0
	if lastMana <= 0 then gainedMana = 0 end

	-- when gainedMana is below 0 (we create rune or smth set 0)
	if gainedMana < 0 then gainedMana = 0 end

	-- set new value to last mana
	lastMana = mana

	-- return gained mana
	return gainedMana

end	

-- Module working in loop.
Module.New("Medivia Random Rune Make", function (mod)
	
	-- when we are connected.
	if Self.isConnected() then

		-- when check for mana charging
		if ANTI_GM_MANA_CHARGE.enabled then

			-- load mana regen
			local regen = getManaRegen()

			-- when regen is above 10
			if regen >= 10 then

				-- set charged time
				chargedTime = os.clock()

				print("Mana of your character was charged by " .. regen)

			end	

		end	

		-- When self mana is near on target and don't charged mana.
		if Self.ManaPercent() >= MANA_PERCENT and os.clock() - chargedTime >= ANTI_GM_MANA_CHARGE.wait_min then

			-- inside loop cast spell.
			for i = 1, rand do

				-- put blank do hand
				Self.EquipItem(SLOT_WEAPON, BLANKID)

				-- wait some time
				wait(700, 1000)

				-- when we check for players
				if WHEN_PALYER_DONT_DO_THIS then
				
					-- when player detected break
					if getPlayer() then break end

				end	

				-- cast spell.
				Self.CastSpell(SPELL)

				-- wait ~2-3s
				wait(2200, 3000)

			end	

			-- set random cast times.
			rand = math.random(CAST_TIMES[1], CAST_TIMES[2])

		end	

	end	

	-- set random delay
	mod:Delay(SCRIPT_DELAY[1], SCRIPT_DELAY[2])

end)
