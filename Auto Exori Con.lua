--[[
    Script Name: 		Auto Exori Con
    Description: 		Cast exori con if target > 0 and hpperc > 50%
    Author: 			Ascer - example
]]

local SPELL = "exori con"   -- spell to cast
local HPPERC = 50			-- don't cast if hp below %
local MONSTERS = {"Dragon", "Dragon Lord", "Rat"} -- shoot only with in this monsters.

-- DON'T EDIT BELOW
MONSTERS = table.lower(MONSTERS)

-- module
Module.New("Auto Exori Con", function (mod)
    
	-- load self hpperc and targetid
    local hp = Self.HealthPercent()
    local target = Self.TargetID()

    -- when hp is ok and we have target
    if hp > HPPERC and target > 0 then

    	-- load attacked creature
        local mob = Creature.getCreatures(target)
        
        -- when name of this creature is in table.
        if table.find(MONSTERS, string.lower(mob.name)) then

        	-- cast spell
        	Self.CastSpell(SPELL)

        end
        	
    end

    -- execure delay
    mod:Delay(300, 500)

end)
