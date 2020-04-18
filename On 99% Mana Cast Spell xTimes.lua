--[[
    Script Name:        On 99% Mana Cast Spell xTimes
    Description:       	When your mana reach 99% then cast spell example 4 times.
    Author:             Ascer - example
]]

local MANA_PERCENT = 99					-- cast spell when mana percent reach this %.
local CAST_TIMES = 4					-- cast spell x times.
local SPELL = "exura"					-- spell name
local WHEN_PALYER_DONT_DO_THIS = false	-- when player appear on screen don't cast spell
local FRIENDS = {"Friend1", "Friend2"}  -- ignore this names (Capital letter)

-- DON'T EDIT BELOW THIS LINE.



---------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getPlayer()
--> Description:    Get player on screen
--> Class:          Self
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

-- Module working in loop.
Module.New("On 99% Mana Cast Spell xTimes", function (mod)
	
	-- when we are connected.
	if Self.isConnected() then

		-- When self mana is near on target.
		if Self.ManaPercent() >= MANA_PERCENT then

			-- inside loop cast spell.
			for i = 1, CAST_TIMES do

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

		end	

	end	

	-- set random delay
	mod:Delay(300, 1200)

end)
